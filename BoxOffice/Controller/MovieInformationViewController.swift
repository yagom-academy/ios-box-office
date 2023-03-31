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
    private var movieInformation: MovieInformation?
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
                DispatchQueue.main.async {
                    self?.movieInformationScrollView.movie = result.movieInformationResult.movie
                    self?.movieInformationScrollView.configure()
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
        movieInformationScrollView.moviePosterImageView.load(url: imageURL) { [weak self] result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let image):
                DispatchQueue.main.async {
                    self?.movieInformationScrollView.moviePosterImageView.image = image
                    self?.loadingView.stopAnimating()
                }
            }
        }
    }
}

extension UIImageView {
    func load(url: URL, completion: @escaping ((Result<UIImage, NetworkError>) -> Void)) {
        let urlRequest = URLRequest(url: url)
        
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
