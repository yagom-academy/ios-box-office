//
//  MovieInfoViewController.swift
//  BoxOffice
//
//  Created by kaki, harry on 2023/03/29.
//

import UIKit

final class MovieInfoViewController: UIViewController {
    @IBOutlet private weak var posterImageView: UIImageView!
    
    private let movieCode: String?
    private let movieName: String?
    private let networkManager = NetworkManager()
    private var movieInfo: Movie?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = movieName
        fetchMoviePoster()
    }
    
    init?(movieCode: String?, movieName: String?, coder: NSCoder) {
        self.movieCode = movieCode
        self.movieName = movieName
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func fetchMovieInfo() {
        guard let movieCode = movieCode else { return }
        let endPoint: BoxOfficeEndPoint = .fetchMovieInfo(movieCode: movieCode)
        
        networkManager.fetchData(request: endPoint.createRequest(), type: Movie.self) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    self.movieInfo = data
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    private func fetchMoviePoster() {
        guard let movieName = movieName else { return }
        let endPoint: BoxOfficeEndPoint = .fetchMoviePoster(movieName: movieName)
        
        networkManager.fetchData(request: endPoint.createRequest(), type: MoviePoster.self) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    guard let urlText = data.items.first?.imageURLText else { return }
                    let url = URL(string: urlText.replacingOccurrences(of: "mit110", with: "mit500"))
                    self.posterImageView.load(url: url)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
}
