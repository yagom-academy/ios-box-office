//
//  MovieInformationViewController.swift
//  BoxOffice
//
//  Created by 리지, kokkilE on 2023/03/29.
//

import UIKit

final class MovieInformationViewController: UIViewController {
    private let movieInformationScrollView = MovieInformationScrollView()
    
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
        configureScrollView()
        fetchMovieInformation()
        fetchMoviePosterImage()
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
    
    private func fetchMoviePosterImage() {
        networkManager.request(endPoint: moviePosterImageEndPoint, returnType: MoviePosterImage.self) { [weak self] in
            switch $0 {
            case .failure(let error):
                print(error)
            case .success(let result):
                DispatchQueue.main.async {
                    guard let firstDocument = result.documents.first,
                          let imageURL = URL(string: firstDocument.imageURL) else { return }
                    self?.movieInformationScrollView.moviePosterImageView.load(url: imageURL)
                }
            }
        }
    }
}

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            guard let data = try? Data(contentsOf: url),
                  let image = UIImage(data: data) else { return }
            DispatchQueue.main.async {
                self?.image = image
            }
        }
    }
}
