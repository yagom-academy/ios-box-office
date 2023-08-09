//
//  MovieDetailViewController.swift
//  BoxOffice
//
//  Created by EtialMoon, Minsup on 2023/08/08.
//

import UIKit

final class MovieDetailViewController: UIViewController {
    var boxOfficeItem: BoxOfficeItem?
    let movieDetailView = MovieDetailView()
    
    override func loadView() {
        view = movieDetailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigation()
        configureIndicator()
        fetchData()
    }
    
    convenience init(boxOfficeItem: BoxOfficeItem) {
        self.init(nibName: nil, bundle: nil)
        self.boxOfficeItem = boxOfficeItem
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func fetchData() {
        Task { [weak self] in
            Indicator.shared.startAnimating()
            guard let self, let boxOfficeItem = self.boxOfficeItem else { return }
            async let movieInformation = self.fetchMovieInformation(movieCode: boxOfficeItem.movieCode)
            async let posterImage = self.fetchPosterImage(movieName: boxOfficeItem.movieName)
            self.movieDetailView.injectMovieInformation(await movieInformation, image: await posterImage)
            Indicator.shared.stopAnimating()
        }
    }
    
    private func fetchMovieInformation(movieCode: String) async -> MovieInformation? {
        do {
            let movie: Movie = try await NetworkManager.fetchData(fetchType: .movie(code: movieCode))
            return movie.movieResult.movieInformation
        } catch {
            showAlert(error: error)
            return nil
        }
    }
    
    private func fetchPosterImage(movieName: String) async -> UIImage? {
        do {
            return try await NetworkManager.fetchImage(movieName: movieName)
        } catch {
            showAlert(error: error)
            return nil
        }
    }
    
    private func showAlert(error: Error) {
        let alert = UIAlertController(
            title: "에러",
            message: "\(error.localizedDescription)",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true, completion: nil)
    }
}

extension MovieDetailViewController {
    private func configureNavigation() {
        guard let boxOfficeItem = self.boxOfficeItem else { return }
        self.navigationItem.title = boxOfficeItem.movieName
    }
    
    private func configureIndicator() {
        self.view.addSubview(Indicator.shared)
        
        Indicator.shared.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            Indicator.shared.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            Indicator.shared.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
}
