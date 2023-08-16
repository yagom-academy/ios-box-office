//
//  MovieDetailViewController.swift
//  BoxOffice
//
//  Created by Zion, Hemg on 2023/08/09.
//

import UIKit

protocol MovieDetailViewControllerUseCaseDelegate: AnyObject {
    func completeFetchMovieDetailInformation()
    func completFetchMovieDetailDescription(_ movieDetailInformationDTO: MovieDetailInformationDTO)
    func completeFetchMovieDetailImage(_ movieDetailImageDTO: MovieDetailImageDTO)
    func failFetchMovieDetailInformation(_ errorDescription: String?)
}

final class MovieDetailViewController: UIViewController, CanShowNetworkRequestFailureAlert {
    private let movieDetailView = MovieDetailView()
    private let usecase: MovieDetailViewControllerUseCase
    
    init(usecase: MovieDetailViewControllerUseCase) {
        self.usecase = usecase
        
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
        setUpViewControllerContents()
    }
    
    private func setUpViewController() {
        view.backgroundColor = .systemBackground
        navigationItem.title = usecase.movieName
    }
    
    private func setUpViewControllerContents() {
        usecase.fetchMovieDetailInformation()
    }
}

// MARK: - MovieDetailViewControllerUseCaseDelegate
extension MovieDetailViewController: MovieDetailViewControllerUseCaseDelegate  {
    func completeFetchMovieDetailInformation() {
        
    }
    
    func completFetchMovieDetailDescription(_ movieDetailInformationDTO: MovieDetailInformationDTO) {
        movieDetailView.setUpContents(movieDetailInformationDTO)
    }
    
    func completeFetchMovieDetailImage(_ movieDetailImageDTO: MovieDetailImageDTO) {
        movieDetailView.setUpImageContent(movieDetailImageDTO)
    }
    
    func failFetchMovieDetailInformation(_ errorDescription: String?) {
        showNetworkFailAlert(message: errorDescription, retryFunction: setUpViewControllerContents)
    }
}
