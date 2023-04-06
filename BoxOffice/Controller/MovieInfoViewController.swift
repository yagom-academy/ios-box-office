//
//  MovieInfoViewController.swift
//  BoxOffice
//
//  Created by Christy, Hyemory on 2023/03/31.
//

import UIKit

final class MovieInfoViewController: UIViewController {
    private let movieCode: String
    private var movie: Movie?
    private var moviePoster: MoviePoster?
    private let networkManager = NetworkManager()
    private let dateFormatter = DateFormatter()
    private var movieInfo: [(title: String, value: String)] = []
    
    private let contentScrollView = {
        let scrollView = UIScrollView()
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsVerticalScrollIndicator = false
        
        return scrollView
    }()
    
    private var posterImageView = {
        let imageView = UIImageView()
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    private let loadingView = {
        let view = LoadingView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
      }()
    
    private let movieInfoListStackView = {
        let stackView = UIStackView()
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 12
        
        return stackView
    }()
    
    init(movieCode: String) {
        self.movieCode = movieCode
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUIOption()
        fetchMovieInfo()
    }
    
    private func configureUIOption() {
        view.backgroundColor = .systemBackground
        loadingView.isLoading = true
    }
    
    private func fetchMovieInfo() {
        let urlRequest = EndPoint.movieInfo(movieCode: movieCode).asURLRequest()
        
        networkManager.fetchData(urlRequest: urlRequest, type: Movie.self) { [weak self] result in
            switch result {
            case .success(let movieInfo):
                self?.movie = movieInfo
                
                guard let movieInfo = self?.movie?.result.movieInfo else { return }
                
                DispatchQueue.main.async {
                    self?.configureUI(of: movieInfo)
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.presentAlert(from: error)
                }
            }
        }
    }
    
    private func configureUI(of movieInfo: MovieInfo) {
        navigationItem.title = movieInfo.movieName
        
        fetchMoviePoster()
        configureScrollView()
        configureMovieInfo(data: movieInfo)
        configureMovieInfoListStackView()
        configureMovieInfoLayout()
    }
    
    private func fetchMoviePoster() {
        let movieName = movie?.result.movieInfo.movieName ?? ""
        let urlRequest = EndPoint.moviePoster(searchFor: movieName + " 영화 포스터").asURLRequest()
        
        networkManager.fetchData(urlRequest: urlRequest, type: MoviePoster.self) { [weak self] result in
            switch result {
            case .success(let moviePosterInfo):
                self?.moviePoster = moviePosterInfo
                
                guard let url = URL(string: moviePosterInfo.documents.first?.imageURL ?? ""),
                      let data = try? Data(contentsOf: url) else { return }
                
                DispatchQueue.main.async {
                    self?.posterImageView.image = UIImage(data: data)
                    self?.loadingView.isLoading = false
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.presentAlert(from: error)
                }
            }
        }
    }
    
    private func presentAlert(from error: Error) {
        guard let networkingError = error as? NetworkingError else { return }
        let alert = UIAlertController(title: networkingError.description, message: "모리스티에게 문의해 주세요.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "닫기", style: .cancel))
        present(alert, animated: true)
    }
    
    private func configureScrollView() {
        view.addSubview(contentScrollView)
        view.addSubview(loadingView)
        
        contentScrollView.addSubview(posterImageView)
        contentScrollView.addSubview(movieInfoListStackView)
        
        NSLayoutConstraint.activate([
            contentScrollView.topAnchor.constraint(equalTo: view.topAnchor),
            contentScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            contentScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            contentScrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            loadingView.leftAnchor.constraint(equalTo: contentScrollView.leftAnchor),
            loadingView.rightAnchor.constraint(equalTo: contentScrollView.rightAnchor),
            loadingView.bottomAnchor.constraint(equalTo: contentScrollView.bottomAnchor),
            loadingView.topAnchor.constraint(equalTo: contentScrollView.topAnchor),
        ])
    }

    private func configureMovieInfo(data: MovieInfo) {
        dateFormatter.dateFormat = "yyyyMMdd"
        let directors = data.directors.map(\.name).joined(separator: ", ")
        let productionYear = data.productionYear
        let openDate = data.openDate.toDate(formatter: dateFormatter)
        let showTime = data.showTime
        let watchGradeName = data.audits.map(\.watchGradeName).joined(separator: ", ")
        let nations = data.nations.map(\.name).joined(separator: ", ")
        let genres = data.genres.map(\.name).joined(separator: ", ")
        let actors = data.actors.map(\.name).joined(separator: ", ")
        
        dateFormatter.dateFormat = "yyyy-MM-dd"
        movieInfo = [(title: "감독", value: directors),
                    (title: "제작년도", value: productionYear),
                    (title: "개봉일", value: openDate?.showYesterdayDate(formatter: dateFormatter) ?? "개봉일 정보 없음"),
                    (title: "상영시간", value: showTime),
                    (title: "관람등급", value: watchGradeName),
                    (title: "제작국가", value: nations),
                    (title: "장르", value: genres),
                    (title: "배우", value: actors)
        ]
    }
    
    private func configureMovieInfoListStackView() {
        movieInfo.forEach { item in
            movieInfoListStackView.addArrangedSubview(RowStackView(title: item.title, value: item.value))
        }
    }
    
    private func configureMovieInfoLayout() {
        NSLayoutConstraint.activate([
            posterImageView.centerXAnchor.constraint(equalTo: contentScrollView.centerXAnchor),
            posterImageView.topAnchor.constraint(equalTo: contentScrollView.topAnchor),
            posterImageView.widthAnchor.constraint(equalTo: contentScrollView.widthAnchor, multiplier: 0.9),
            posterImageView.heightAnchor.constraint(equalTo: contentScrollView.heightAnchor, multiplier: 0.6),
            
            movieInfoListStackView.topAnchor.constraint(equalTo: posterImageView.bottomAnchor),
            movieInfoListStackView.leadingAnchor.constraint(equalTo: contentScrollView.leadingAnchor),
            movieInfoListStackView.trailingAnchor.constraint(equalTo: contentScrollView.trailingAnchor),
            movieInfoListStackView.widthAnchor.constraint(equalTo: contentScrollView.widthAnchor),
            movieInfoListStackView.bottomAnchor.constraint(equalTo: contentScrollView.bottomAnchor),
        ])
    }
}
