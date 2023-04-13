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
    private let coreDataManager = CoreDataManager<MovieInformationData, MovieDetails>()
    private let typeChanger = TypeChanger()
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
        if let fetchedData = coreDataManager.read(key: movieCode),
           let movieDetails = fetchedData.movieDetails {
           let movieInformationItem = MovieInformationItem(from: movieDetails)
            
            DispatchQueue.main.async { [weak self] in
                self?.movieInformationScrollView.setupDescriptionLabels(
                director: movieInformationItem.directors, productionYear: movieInformationItem.productionYear, openDate: movieInformationItem.openDate, showTime: movieInformationItem.showTime, watchGrade: movieInformationItem.audits, nation: movieInformationItem.nations, genre: movieInformationItem.genres, actor: movieInformationItem.actors)
            }
            
            return
        }
        
        networkManager.request(endPoint: boxOfficeEndPoint, returnType: MovieInformation.self) { [weak self] in
            switch $0 {
            case .failure(let error):
                print(error)
            case .success(let result):
                guard let movieCode = self?.movieCode,
                      let entity = self?.typeChanger.changeToEntity(result.movieInformationResult.movie) else { return }
                
                self?.coreDataManager.create(key: movieCode, value: [entity])
                
                guard let fetchedData = self?.coreDataManager.read(key: movieCode),
                      let movieDetails = fetchedData.movieDetails else { return }
                
                let movieInformationItem = MovieInformationItem(from: movieDetails)
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
        if let cachedImage = ImageCacheManager.shared.read(key: imageURL.absoluteString) as? UIImage {
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
                ImageCacheManager.shared.create(key: imageURL.absoluteString, value: [image])
                DispatchQueue.main.async {
                    self?.movieInformationScrollView.setupMoviePoterImage(image)
                    self?.loadingView.stopAnimating()
                }
            }
        }
    }
}

struct MovieInformationItem {
    var directors: String = ""
    var productionYear: String = ""
    var openDate: String = ""
    var showTime: String = ""
    var audits: String = ""
    var nations: String = ""
    var genres: String = ""
    var actors: String = ""
    
    init(from movie: MovieDetails) {
        self.directors = {
            guard let movieDirectors = movie.directorsName else { return "" }

            var directors = ""

            for index in 0..<movieDirectors.count {
                if index == 0 {
                    directors = movieDirectors[index]
                } else {
                    directors = directors + ", " + movieDirectors[index]
                }
            }

            return directors
        }()
        self.audits = {
            guard let movieAudits = movie.auditsWatchGrade else { return "" }

            var audits = ""
            for index in 0..<movieAudits.count {
                if index == 0 {
                    audits = movieAudits[index]
                } else {
                    audits = audits + ", " + movieAudits[index]
                }
            }

            return audits
        }()
        self.nations = {
            guard let movieNations = movie.nationsName else { return "" }

            var nations = ""
            for index in 0..<movieNations.count {
                if index == 0 {
                    nations = movieNations[index]
                } else {
                    nations = nations + ", " + movieNations[index]
                }
            }

            return nations
        }()
        self.genres = {
            guard let movieGenres = movie.genresName else { return "" }

            var genres = ""
            for index in 0..<movieGenres.count {
                if index == 0 {
                    genres = movieGenres[index]
                } else {
                    genres = genres + ", " + movieGenres[index]
                }
            }

            return genres
        }()
        self.actors = {
            guard let movieActors = movie.actorsName else { return "" }

            var actors = ""
            for index in 0..<movieActors.count {
                if index == 0 {
                    actors = movieActors[index]
                } else {
                    actors = actors + ", " + movieActors[index]
                }
            }

            return actors
        }()
        
        if let movieProductionYear = movie.productionYear {
            self.productionYear = movieProductionYear
        }
        
        if let movieOpenDate = movie.openDate {
            self.openDate = movieOpenDate
        }
        
        if let movieShowTime = movie.showTime {
            self.showTime = movieShowTime
        }
    }
}
