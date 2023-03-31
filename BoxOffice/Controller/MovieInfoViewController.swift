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
    private let networkManager = NetworkManager()
    private let movieInfoListStackView = UIStackView()
    private let directorsStackView: RowStackView?
//    private let directorsStackView: RowStackView?
//    private let directorsStackView: RowStackView?
//    private let directorsStackView: RowStackView?
//    private let directorsStackView: RowStackView?
//    private let directorsStackView: RowStackView?
//    private let directorsStackView: RowStackView?
//    private let directorsStackView: RowStackView?
    
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
        
        fetchMovieInfo()

        layout()
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
                    self?.configureMovieInfoListStackView(data: (self?.movie?.result.movieInfo)!)
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
    
    private func configureMovieInfoListStackView(data: MovieInfo) {
        
        movieInfoListStackView.translatesAutoresizingMaskIntoConstraints = false
        movieInfoListStackView.axis = .vertical
        movieInfoListStackView.alignment = .center
        
        view.addSubview(movieInfoListStackView)
        
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
        
        // RowStackView 오토레이아웃 잡아야 함!
        
        NSLayoutConstraint.activate([
            movieInfoListStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            movieInfoListStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            movieInfoListStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            movieInfoListStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
        ])
        
    }
    
    private func layout() {
        
    }
}
