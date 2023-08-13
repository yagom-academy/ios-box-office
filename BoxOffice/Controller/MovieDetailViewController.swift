//
//  MovieDetailViewController.swift
//  BoxOffice
//
//  Created by EtialMoon, Minsup on 2023/08/08.
//

import UIKit

final class MovieDetailViewController: UIViewController {
    private var boxOfficeItem: BoxOfficeItem
    private let movieDetailView = MovieDetailView()
    
    override func loadView() {
        view = movieDetailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigation()        
        fetchData()
    }
    
    init(boxOfficeItem: BoxOfficeItem) {
        self.boxOfficeItem = boxOfficeItem
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func fetchData() {
        Task {
            movieDetailView.indicatorView.startAnimating()
            do {
                async let movieInformation = self.fetchMovieInformation(movieCode: boxOfficeItem.movieCode)
                async let posterImage = self.fetchPosterImage(movieName: boxOfficeItem.movieName)
                
                movieDetailView.configureMovieInformation(try await movieInformation)
                movieDetailView.configurePosterImage(try await posterImage)                
            } catch {
                self.showAlert(error: error)
            }
            movieDetailView.indicatorView.stopAnimating()
        }
    }
    
    private func fetchMovieInformation(movieCode: String) async throws -> MovieInformation? {
        let movie: Movie = try await NetworkManager.fetchData(fetchType: .movie(code: movieCode))
        return movie.movieResult.movieInformation
    }
    
    private func fetchPosterImage(movieName: String) async throws -> UIImage? {
        return try await NetworkManager.fetchImage(movieName: movieName)
    }
    
    private func showAlert(error: Error) {
        let alert = UIAlertController(
            title: "에러",
            message: "\(error.localizedDescription)",
            preferredStyle: .alert
        )
        
        alert.addAction(UIAlertAction(title: "재시도", style: .default, handler: { _ in
            self.fetchData()
        }))
        
        alert.addAction(UIAlertAction(title: "확인", style: .default, handler: { _ in
            self.navigationController?.popToRootViewController(animated: true)
        }))
        
        
        self.present(alert, animated: true, completion: nil)
    }
}

extension MovieDetailViewController {
    private func configureNavigation() {
        self.navigationItem.title = boxOfficeItem.movieName
    }
}
