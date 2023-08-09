//
//  MovieDetailViewController.swift
//  BoxOffice
//
//  Created by EtialMoon, Minsup on 2023/08/08.
//

import UIKit

class MovieDetailViewController: UIViewController {
    let movieDetailView = MovieDetailView()
    let indicator = UIActivityIndicatorView()
    var movieCode: String?
    var posterImage: UIImage?
    var movieInformation: MovieInformation?
    
    override func loadView() {
        view = movieDetailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        withIndicator {
            await self.fetchMovieDetail(movieCode: self.movieCode!)
            
            guard let movieInformation = self.movieInformation,
                  let posterImage = self.posterImage else {
                return
            }
            
            self.movieDetailView.injectMovieInformation(movieInformation, image: posterImage)
            
            self.navigationItem.title = movieInformation.movieName
        }
    }
    
    convenience init(movieCode: String) {
        self.init(nibName: nil, bundle: nil)
        
        self.movieCode = movieCode
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func withIndicator(closure: @escaping () async -> Void) {
        Task {
            indicator.startAnimating()
            await closure()
            indicator.stopAnimating()
        }
    }
    
    private func fetchMovieDetail(movieCode: String) async {
        do {
            let movie: Movie = try await NetworkManager.fetchData(fetchType: .movie(code: movieCode))
            movieInformation = movie.movieResult.movieInformation
            
            guard let movieName = movieInformation?.movieName else {
                return
            }
            
            posterImage = try await NetworkManager.fetchImage(movieName: movieName)
        } catch {
            let alert = UIAlertController(
                title: "에러",
                message: "\(error.localizedDescription)",
                preferredStyle: .alert
            )
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(alert, animated: true, completion: nil)
        }
    }
}
