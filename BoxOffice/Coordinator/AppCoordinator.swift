//
//  AppCoordinator.swift
//  BoxOffice
//
//  Created by Zion, Hemg on 2023/08/09.
//

import UIKit

final class AppCoordinator {
    private let navigationController: UINavigationController
    private let sessionProvider: URLSessionProvider
    private let boxOfficeRepository: BoxOfficeRepository
    
    init(navigationController: UINavigationController, sessionProvider: URLSessionProvider, boxOfficeRepository: BoxOfficeRepository) {
        self.navigationController = navigationController
        self.sessionProvider = sessionProvider
        self.boxOfficeRepository = boxOfficeRepository
    }
    
    func start() {
        var usecase: MainViewControllerUseCase = MainViewControllerUseCaseImplementation(boxOfficeRepository: boxOfficeRepository)
        let mainViewController = MainViewController(usecase)
        
        usecase.delegate = mainViewController
        mainViewController.delegate = self
        navigationController.pushViewController(mainViewController, animated: true)
    }
}

// MARK: - MainViewControllerDelegate
extension AppCoordinator: MainViewControllerDelegate {
    func pushMovieDetailViewController(_ movieCode: String, _ movieName: String) {
        let daumSearchRepository: DaumSearchRepository = DaumSearchRepositoryImplementation(sessionProvider: sessionProvider)
        var useCase: MovieDetailViewControllerUseCase = MovieDetailViewControllerUseCaseImplementation(boxOfficeRepository: boxOfficeRepository, daumSearchRepository: daumSearchRepository)
        let movieDetailViewController = MovieDetailViewController(usecase: useCase, movieCode: movieCode, movieName: movieName)
        
        useCase.delegate = movieDetailViewController
        navigationController.pushViewController(movieDetailViewController, animated: true)
    }
}
