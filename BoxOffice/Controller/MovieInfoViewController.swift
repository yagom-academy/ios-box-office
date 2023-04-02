//
//  MovieInfoViewController.swift
//  BoxOffice
//
//  Created by Christy, Hyemory on 2023/03/31.
//

import UIKit

class MovieInfoViewController: UIViewController {
    let movieCode: String
    private var movie: Movie?
    private var moviePoster: MoviePoster?
    private var posterImageView = UIImageView()
    private let networkManager = NetworkManager()
    private let contentScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsVerticalScrollIndicator = false
        
        return scrollView
    }()
    
    private let loadingView: LoadingVIew = {
        let view = LoadingVIew()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
      }()
    
    private let movieInfoListStackView = UIStackView()
    
    init(movieCode: String) {
        self.movieCode = movieCode
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        self.loadingView.isLoading = true
        fetchMovieInfo()
    }
    
    private func fetchMovieInfo() {
        var api = BoxOfficeURLRequest(service: .movieInfo)
        let queryName = "movieCd"
        
        api.addQuery(name: queryName, value: movieCode)
        
        let urlRequest = api.request()
        
        networkManager.fetchData(urlRequest: urlRequest, type: Movie.self) { [weak self] result in
            switch result {
            case .success(let data):
                self?.movie = data
                
                DispatchQueue.main.async {
                    self?.navigationItem.title = self?.movie?.result.movieInfo.movieName
                    self?.configureScrollView()
                    self?.configureMovieInfoListStackView(data: (self?.movie?.result.movieInfo)!)
                    self?.fetchMoviePoster()
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.displayAlert(from: error)
                }
            }
        }
    }
    
    private func fetchMoviePoster() {
        var api = BoxOfficeURLRequest(service: .moviePoster)
        let queryName = "query"
        let movieName = movie?.result.movieInfo.movieName ?? ""
        
        api.addQuery(name: queryName, value: (movieName + " 영화 포스터"))
        
        let urlRequest = api.request()
        
        networkManager.fetchData(urlRequest: urlRequest, type: MoviePoster.self) { [weak self] result in
            switch result {
            case .success(let data):
                self?.moviePoster = data
                
                guard let url = URL(string: data.documents.first?.imageURL ?? ""),
                      let data = try? Data(contentsOf: url) else { return }
                
                DispatchQueue.main.async {
                    self?.loadingView.isLoading = false
                    self?.posterImageView.image = UIImage(data: data)
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.displayAlert(from: error)
                }
            }
        }
    }
    
    private func displayAlert(from error: Error) {
        guard let networkingError = error as? NetworkingError else { return }
        let alert = UIAlertController(title: networkingError.description, message: "모리스티에게 문의해 주세요.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "닫기", style: .cancel))
        present(alert, animated: true)
    }
    
    private func configureScrollView() {
        self.view.addSubview(contentScrollView)
        self.view.addSubview(loadingView)
        
        NSLayoutConstraint.activate([
            contentScrollView.topAnchor.constraint(equalTo: self.view.topAnchor),
            contentScrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            contentScrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            contentScrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            
            loadingView.leftAnchor.constraint(equalTo: self.contentScrollView.leftAnchor),
            loadingView.rightAnchor.constraint(equalTo: self.contentScrollView.rightAnchor),
            loadingView.bottomAnchor.constraint(equalTo: self.contentScrollView.bottomAnchor),
            loadingView.topAnchor.constraint(equalTo: self.contentScrollView.topAnchor),
        ])
    }

    private func configureMovieInfoListStackView(data: MovieInfo) {
        
        movieInfoListStackView.translatesAutoresizingMaskIntoConstraints = false
        movieInfoListStackView.axis = .vertical
        movieInfoListStackView.spacing = 12
        
        posterImageView.translatesAutoresizingMaskIntoConstraints =  false
        
        contentScrollView.addSubview(posterImageView)
        contentScrollView.addSubview(movieInfoListStackView)
        
        let directors = data.directors.map { $0.name }.joined(separator: ", ")
        let productionYear = data.productionYear
        let openDate = data.openDate
        let showTime = data.showTime
        let watchGradeName = data.audits.map { $0.watchGradeName }.joined(separator: ", ")
        let nations = data.nations.map { $0.name }.joined(separator: ", ")
        let genres = data.genres.map { $0.name }.joined(separator: ", ")
        let actors = data.actors.map { $0.name }.joined(separator: ", ")
        
        movieInfoListStackView.addArrangedSubview(RowStackView(title: "감독", value: directors))
        movieInfoListStackView.addArrangedSubview(RowStackView(title: "제작년도", value: productionYear))
        movieInfoListStackView.addArrangedSubview(RowStackView(title: "개봉일", value: openDate))
        movieInfoListStackView.addArrangedSubview(RowStackView(title: "상영시간", value: showTime))
        movieInfoListStackView.addArrangedSubview(RowStackView(title: "관람등급", value: watchGradeName))
        movieInfoListStackView.addArrangedSubview(RowStackView(title: "제작국가", value: nations))
        movieInfoListStackView.addArrangedSubview(RowStackView(title: "장르", value: genres))
        movieInfoListStackView.addArrangedSubview(RowStackView(title: "배우", value: actors))
        
        NSLayoutConstraint.activate([
            posterImageView.centerXAnchor.constraint(equalTo: contentScrollView.centerXAnchor),
            posterImageView.topAnchor.constraint(equalTo: contentScrollView.topAnchor),
            posterImageView.widthAnchor.constraint(equalTo: contentScrollView.widthAnchor, multiplier: 0.9),
            posterImageView.heightAnchor.constraint(equalTo: contentScrollView.heightAnchor, multiplier: 0.6),
            
            movieInfoListStackView.topAnchor.constraint(equalTo: posterImageView.bottomAnchor),
            movieInfoListStackView.leadingAnchor.constraint(equalTo: contentScrollView.leadingAnchor),
            movieInfoListStackView.trailingAnchor.constraint(equalTo: contentScrollView.trailingAnchor),
            movieInfoListStackView.widthAnchor.constraint(equalTo: contentScrollView.widthAnchor),
            movieInfoListStackView.bottomAnchor.constraint(equalTo: contentScrollView.bottomAnchor)
        ])
    }
}
