//
//  MovieDetailViewController.swift
//  BoxOffice
//
//  Created by Zion, Hemg on 2023/08/09.
//

import UIKit

protocol MovieDetailViewControllerUseCaseDelegate: AnyObject {
    
}

final class MovieDetailViewController: UIViewController {
    private let movieDetailView: MovieDetailView = {
        let movieDetailView = MovieDetailView()
        
        return movieDetailView
    }()
    
    private let usecase: MovieDetailViewControllerUseCase
    private let movieCode: String
    private let movieName: String
    
    init(usecase: MovieDetailViewControllerUseCase, movieCode: String, movieName: String) {
        self.usecase = usecase
        self.movieCode = movieCode
        self.movieName = movieName
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = movieDetailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpViewController()
    }
    
    private func setUpViewController() {
        view.backgroundColor = .systemBackground
        navigationItem.title = movieName
    }
}


extension MovieDetailViewController: MovieDetailViewControllerUseCaseDelegate  {
    
}
