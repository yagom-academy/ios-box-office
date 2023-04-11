//
//  MovieInformationViewController.swift
//  BoxOffice
//
//  Created by 리지, kokkilE on 2023/03/29.
//

import UIKit

final class MovieInformationViewController: UIViewController {
    private let movieInformationScrollView = MovieInformationScrollView()
    private let loadingView = UIActivityIndicatorView(style: .large)
    
    private let networkManager = NetworkManager()
    private let movieName: String
    private let movieCode: String
    
    private let boxOfficeEndPoint: BoxOfficeEndPoint
    private let moviePosterImageEndPoint: BoxOfficeEndPoint
    
    init(movieName: String, movieCode: String) {
        self.movieName = movieName
        self.movieCode = movieCode
        self.boxOfficeEndPoint = BoxOfficeEndPoint.MovieInformation(movieCode: movieCode)
        self.moviePosterImageEndPoint = BoxOfficeEndPoint.MoviePosterImage(query: movieName + " 영화 포스터")
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        self.title = movieName
        
        view.addSubview(movieInformationScrollView)
        view.addSubview(loadingView)
        
        loadingView.startAnimating()
        configureScrollView()
        configureLoadingView()
        fetchMoviePoster()
        fetchMovieInformation()
    }
    
    private func configureLoadingView() {
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            loadingView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadingView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    private func configureScrollView() {
        movieInformationScrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            movieInformationScrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            movieInformationScrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            movieInformationScrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            movieInformationScrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
    
    private func fetchMovieInformation() {
        if let fetchedData = MovieInformationCoreDataManager.shared.read(key: movieCode) as? MovieInformationData,
           let details = fetchedData.details {
           let movieInformationItem = MovieInformationItem(from: details)
            
            DispatchQueue.main.async { [weak self] in
                self?.movieInformationScrollView.setupDescriptionLabels(
                director: movieInformationItem.directors, productionYear: movieInformationItem.productionYear, openDate: movieInformationItem.openDate, showTime: movieInformationItem.showTime, watchGrade: movieInformationItem.audits, nation: movieInformationItem.nations, genre: movieInformationItem.genres, actor: movieInformationItem.actors)
            }
        }
        
        networkManager.request(endPoint: boxOfficeEndPoint, returnType: MovieInformation.self) { [weak self] in
            switch $0 {
            case .failure(let error):
                print(error)
            case .success(let result):
                guard let movieCode = self?.movieCode else { return }
                MovieInformationCoreDataManager.shared.create(key: movieCode, value: [result.movieInformationResult.movie])
                
                guard let fetchedData = MovieInformationCoreDataManager.shared.read(key: movieCode) as? MovieInformationData,
                      let details = fetchedData.details else { return }
                
                let movieInformationItem = MovieInformationItem(from: details)
                DispatchQueue.main.async {
                    self?.movieInformationScrollView.setupDescriptionLabels(director: movieInformationItem.directors, productionYear: movieInformationItem.productionYear, openDate: movieInformationItem.openDate, showTime: movieInformationItem.showTime, watchGrade: movieInformationItem.audits, nation: movieInformationItem.nations, genre: movieInformationItem.genres, actor: movieInformationItem.actors)
                }
            }
        }
    }
    
    private func fetchMoviePoster() {
        networkManager.request(endPoint: moviePosterImageEndPoint, returnType: MoviePosterImage.self) { [weak self] in
            switch $0 {
            case .failure(let error):
                print(error)
            case .success(let result):
                guard let firstDocument = result.documents.first,
                      let imageURL = URL(string: firstDocument.imageURL) else { return }
                self?.fetchMoviePosterImage(from: imageURL)
            }
        }
    }
    
    private func fetchMoviePosterImage(from imageURL: URL) {
        if let cachedImage = ImageCacheManager.shared.cachedImage(urlString: imageURL.absoluteString) {
            DispatchQueue.main.async {
                self.movieInformationScrollView.setupMoviePoterImage(cachedImage)
                self.loadingView.stopAnimating()
                return
            }
        }
        
        networkManager.loadImage(from: imageURL) { [weak self] result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let image):
                ImageCacheManager.shared.setObject(image: image, urlString: imageURL.absoluteString)
                DispatchQueue.main.async {
                    self?.movieInformationScrollView.setupMoviePoterImage(image)
                    self?.loadingView.stopAnimating()
                }
            }
        }
    }
}

struct MovieInformationItem: Hashable {
    let identifier = UUID()
    var directors: String = ""
    var productionYear: String = ""
    var openDate: String = ""
    var showTime: String = ""
    var audits: String = ""
    var nations: String = ""
    var genres: String = ""
    var actors: String = ""
    
    
    init(from movie: Details) {
        guard let movieDirectors = movie.directors,
              let movieAudits = movie.audits,
              let movieNations = movie.nations,
              let movieGenres = movie.genres,
              let movieActors = movie.actors,
              let movieProductionYear = movie.productionYear,
              let movieOpenDate = movie.openDate,
              let movieShowTime = movie.showTime else { return }
            
        self.directors = {
            var directors = ""
            for index in 0..<movieDirectors.count {
                if index == 0 {
                    directors = movieDirectors[index].name
                } else {
                    directors = directors + ", " + movieDirectors[index].name
                }
            }
            
            return directors
        }()
        self.audits = {
            var audits = ""
            for index in 0..<movieAudits.count {
                if index == 0 {
                    audits = movieAudits[index].watchGrade
                } else {
                    audits = audits + ", " + movieAudits[index].watchGrade
                }
            }
            
            return audits
        }()
        self.nations = {
            var nations = ""
            for index in 0..<movieNations.count {
                if index == 0 {
                    nations = movieNations[index].name
                } else {
                    nations = nations + ", " + movieNations[index].name
                }
            }
            
            return nations
        }()
        self.genres = {
            var genres = ""
            for index in 0..<movieGenres.count {
                if index == 0 {
                    genres = movieGenres[index].name
                } else {
                    genres = genres + ", " + movieGenres[index].name
                }
            }
            
            return genres
        }()
        self.actors = {
            var actors = ""
            for index in 0..<movieActors.count {
                if index == 0 {
                    actors = movieActors[index].name
                } else {
                    actors = actors + ", " + movieActors[index].name
                }
            }
            
            return actors
        }()
        
        self.productionYear = movieProductionYear
        self.openDate = movieOpenDate
        self.showTime = movieShowTime
    }
}

