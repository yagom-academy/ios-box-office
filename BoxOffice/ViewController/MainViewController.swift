//
//  MainViewController.swift
//  BoxOffice
//
//  Created by Zion, Hemg on 13/01/23.
//

import UIKit

protocol MainViewControllerUseCaseDelegate: AnyObject {
    func completeFetchDailyBoxOfficeInformation(_ movieInformationDTOList: [MovieInformationDTO])
    func completeFetchMovieDetailInformation(_ movieDetailResult: MovieDetailResult)
    func failFetchDailyBoxOfficeInformation(_ errorDescription: String?)
    func failFetchMovieDetailInformaion(_ errorDescription: String?)
}

final class MainViewController: UIViewController, CanShowNetworkRequestFailureAlert {
    private let usecase: MainViewControllerUseCase
    
    private lazy var requestMovieDetailInformationButton: UIButton = {
        let button = UIButton()
        
        button.setTitle("영화 개별 상세 조회", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .yellow
        button.addTarget(self, action: #selector(didTappedRequestMovieDetailInformationButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var requestMovieDailyInformationButton: UIButton = {
        let button = UIButton()
        
        button.setTitle("오늘의 일일 박스오피스 조회", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .orange
        button.addTarget(self, action: #selector(didTappedRequestMovieDailyInformationButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var networkRequestFailureButton: UIButton = {
        let button = UIButton()
        
        button.setTitle("네트워크 요청 실패 버튼", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .red
        button.addTarget(self, action: #selector(didTappedNetworkRequestFailureButton), for: .touchUpInside)
        return button
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 5
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
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
        [requestMovieDetailInformationButton, requestMovieDailyInformationButton, networkRequestFailureButton].forEach { stackView.addArrangedSubview($0) }
        view.addSubview(stackView)
    }
    
    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}

// MARK: - MainViewControllerUseCaseDelegate
extension MainViewController: MainViewControllerUseCaseDelegate {
    func completeFetchDailyBoxOfficeInformation(_ movieInformationDTOList: [MovieInformationDTO]) {
        print(movieInformationDTOList)
    }
    
    func completeFetchMovieDetailInformation(_ movieDetailResult: MovieDetailResult) {
        print(movieDetailResult)
    }
    
    func failFetchDailyBoxOfficeInformation(_ errorDescription: String?) {
        DispatchQueue.main.async {
            self.showNetworkFailAlert(message: errorDescription, retryFunction: self.fetchDailyBoxOfficeForTest)
        }
    }
    
    func failFetchMovieDetailInformaion(_ errorDescription: String?) {
        print("\(errorDescription ?? "")")
    }
}

// MARK: - Button Action
extension MainViewController {
    @objc private func didTappedRequestMovieDetailInformationButton() {
        let movieCode = "20228543"
        
        usecase.fetchMovieDetailInformation(movieCode: movieCode)
    }
    
    @objc private func didTappedRequestMovieDailyInformationButton() {
        let tagerDate = "20230723"
        
        usecase.fetchDailyBoxOffice(targetDate: tagerDate)
    }
}

// MARK: - Test Button Action
extension MainViewController {
    private func fetchDailyBoxOfficeForTest() {
        usecase.fetchDailyBoxOffice(targetDate: "")
    }
    
    @objc private func didTappedNetworkRequestFailureButton() {
        fetchDailyBoxOfficeForTest()
    }
}
