//
//  MovieDetailViewController.swift
//  BoxOffice
//
//  Created by vetto, brody on 2023/03/31.
//

import UIKit

final class MovieDetailViewController: UIViewController {
    let movieName: String
    let movieCode: String
    var movieDetailInformation: MovieDetailInformationItem?
    
    init(movieName: String, movieCode: String) {
        self.movieName = movieName
        self.movieCode = movieCode
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        setupUI()
        fetchMovieDetail()
    }
    
    private func setupUI() {
        self.navigationItem.title = movieName
        view.backgroundColor = .white
    }
    
    private func fetchMovieDetail() {
        let boxOfficeProvider = BoxOfficeProvider<BoxOfficeAPI>()
        boxOfficeProvider.fetchData(.detailMovieInformation(movieCode: self.movieCode),
                                    type: MovieInformationDTO.self) { [weak self] result in
            switch result {
            case .success(let data):
                self?.movieDetailInformation = data.toDomain()
                print(self?.movieDetailInformation)
            case .failure:
                print("실패")
            }
        }
    }
}
