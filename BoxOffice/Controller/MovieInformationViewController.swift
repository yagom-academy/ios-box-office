//
//  MovieInformationViewController.swift
//  BoxOffice
//
//  Created by 리지, kokkilE on 2023/03/29.
//

import UIKit

final class MovieInformationViewController: UIViewController {
    var movieInformationStackView = MovieInformationStackView()
    var movieName: String
    var movieCode: String
    lazy var boxOfficeEndPoint = BoxOfficeEndPoint.MovieInformation(movieCode: movieCode, httpMethod: .get)
    let networkManager = NetworkManager()
    var movieInformation: MovieInformation?
    
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
        
        view.addSubview(movieInformationStackView)
        configureContentView()
        fetchMovieInformation()
    }
    
    private func configureContentView() {
        movieInformationStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            movieInformationStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            movieInformationStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            movieInformationStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            movieInformationStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
    
    private func fetchMovieInformation() {
        networkManager.request(endPoint: boxOfficeEndPoint, returnType: MovieInformation.self) { [weak self] in
            switch $0 {
            case .failure(let error):
                print(error)
            case .success(let result):
                DispatchQueue.main.async {
                    self?.movieInformationStackView.movie = result.movieInformationResult.movie
                    self?.movieInformationStackView.configure()
                }
            }
        }
    }
}
