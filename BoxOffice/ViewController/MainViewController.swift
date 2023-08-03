//
//  MainViewController.swift
//  BoxOffice
//
//  Created by Zion, Hemg on 13/01/23.
//

import UIKit

protocol MainViewControllerUseCaseDelegate: AnyObject {
    func completeFetchDailyBoxOfficeInformation(_ movieInformationDTOList: [MovieInformationDTO])
    func failFetchDailyBoxOfficeInformation(_ errorDescription: String?)
}

final class MainViewController: UIViewController, CanShowNetworkRequestFailureAlert {
    private let usecase: MainViewControllerUseCase
    
    init(_ usecase: MainViewControllerUseCase) {
        self.usecase = usecase
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        setUpConstraints()
        setUpBackgroundColor()
    }
    
    private func setUpBackgroundColor() {
        view.backgroundColor = .systemBackground
    }
    
    private func configureUI() {
    }
    
    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            
        ])
    }
}

// MARK: - MainViewControllerUseCaseDelegate
extension MainViewController: MainViewControllerUseCaseDelegate {
    func completeFetchDailyBoxOfficeInformation(_ movieInformationDTOList: [MovieInformationDTO]) {
        print(movieInformationDTOList)
    }
    
    func failFetchDailyBoxOfficeInformation(_ errorDescription: String?) {
        DispatchQueue.main.async {
//            self.showNetworkFailAlert(message: errorDescription, retryFunction: self.fetchDailyBoxOfficeForTest)
        }
    }
}
