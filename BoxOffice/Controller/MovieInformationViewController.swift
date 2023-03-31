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
    private var movieName: String
    private var movieCode: String
    
    lazy private var boxOfficeEndPoint = BoxOfficeEndPoint.MovieInformation(movieCode: movieCode, httpMethod: .get)
    lazy private var moviePosterImageEndPoint = BoxOfficeEndPoint.MoviePosterImage(query: movieName + " 영화 포스터", httpMethod: .get)
    
    init(movieName: String, movieCode: String) {
        self.movieName = movieName
        self.movieCode = movieCode
        
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
        networkManager.request(endPoint: boxOfficeEndPoint, returnType: MovieInformation.self) { [weak self] in
            switch $0 {
            case .failure(let error):
                print(error)
            case .success(let result):
                let movieInformationItem = MovieInformationItem(from: result.movieInformationResult.movie)
                
                DispatchQueue.main.async {
                    self?.movieInformationScrollView.configure(by: movieInformationItem)
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
        let cachedKey = NSString(string: imageURL.absoluteString)
        if let cachedImage = ImageCacheManager.shared.object(forKey: cachedKey) {
            DispatchQueue.main.async {
                self.movieInformationScrollView.moviePosterImageView.image = cachedImage
                self.loadingView.stopAnimating()
                return
            }
        }
        
        loadImage(from: imageURL) { [weak self] result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let image):
                DispatchQueue.main.async {
                    ImageCacheManager.shared.setObject(image, forKey: cachedKey)
                    self?.movieInformationScrollView.moviePosterImageView.image = image
                    self?.loadingView.stopAnimating()
                }
            }
        }
    }
    
    private func loadImage(from imageURL: URL, completion: @escaping ((Result<UIImage, NetworkError>) -> Void)) {
        let urlRequest = URLRequest(url: imageURL)
        
        let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            if error != nil {
                completion(.failure(.unknown))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(.httpResponse))
                return
            }
            
            guard (200...299).contains(httpResponse.statusCode) else {
                completion(.failure(.httpStatusCode(code: httpResponse.statusCode)))
                return
            }
            
            if let data = data {
                guard let result = UIImage(data: data) else {
                    completion(.failure(.decode))
                    return
                }
                completion(.success(result))
            }
        }
        task.resume()
    }
}

struct MovieInformationItem: Hashable {
    init(from movie: MovieInformation.MovieInformationResult.Movie) {
        self.directors = {
            var directors = ""
            for index in 0..<movie.directors.count {
                if index == 0 {
                    directors = movie.directors[index].name
                } else {
                    directors = directors + ", " + movie.directors[index].name
                }
            }
            
            return directors
        }()
        self.audits = {
            var audits = ""
            for index in 0..<movie.audits.count {
                if index == 0 {
                    audits = movie.audits[index].watchGrade
                } else {
                    audits = audits + ", " + movie.audits[index].watchGrade
                }
            }
            
            return audits
        }()
        self.nations = {
            var nations = ""
            for index in 0..<movie.nations.count {
                if index == 0 {
                    nations = movie.nations[index].name
                } else {
                    nations = nations + ", " + movie.nations[index].name
                }
            }
            
            return nations
        }()
        self.genres = {
            var genres = ""
            for index in 0..<movie.genres.count {
                if index == 0 {
                    genres = movie.genres[index].name
                } else {
                    genres = genres + ", " + movie.genres[index].name
                }
            }
            
            return genres
        }()
        self.actors = {
            var actors = ""
            for index in 0..<movie.actors.count {
                if index == 0 {
                    actors = movie.actors[index].name
                } else {
                    actors = actors + ", " + movie.actors[index].name
                }
            }
            
            return actors
        }()
        
        self.productionYear = movie.productionYear
        self.openDate = movie.openDate
        self.showTime = movie.showTime
    }
    
    let identifier = UUID()
    let directors: String
    let productionYear: String
    let openDate: String
    let showTime: String
    let audits: String
    let nations: String
    let genres: String
    let actors: String
}
