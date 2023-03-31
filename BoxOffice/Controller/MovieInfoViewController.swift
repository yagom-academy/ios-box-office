//
//  MovieInfoViewController.swift
//  BoxOffice
//
//  Created by Christy, Hyemory on 2023/03/31.
//

import UIKit

class MovieInfoViewController: UIViewController {
    private var movie: Movie?
    private let networkManager = NetworkManager()
    let movieCode: String
    
    
    init(movieCode: String) {
        self.movieCode = movieCode
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        fetchMovieInfo()
    }
    
    private func fetchMovieInfo() {
        var api = BoxOfficeURLRequest(service: .movieInfo)
        let queryName = "movieCd"
        
        api.addQuery(name: queryName, value: movieCode)
        
        let urlRequest = api.request()
        
        networkManager.fetchData(urlRequest: urlRequest, type: Movie.self) { [weak self] result in
            switch result {
            case .success(let data):
                self?.movie = data
                
                DispatchQueue.main.async {
                    self?.navigationItem.title = self?.movie?.result.movieInfo.movieName
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.displayAlert(from: error)
                }
            }
        }
    }
    
    private func displayAlert(from error: Error) {
        guard let networkingError = error as? NetworkingError else { return }
        let alert = UIAlertController(title: networkingError.description, message: "모리스티에게 문의해 주세요.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "닫기", style: .cancel))
        present(alert, animated: true)
    }
}
