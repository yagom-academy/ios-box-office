//
//  MainViewController.swift
//  BoxOffice
//
//  Created by Zion, Hemg on 13/01/23.
//

import UIKit

protocol MainViewControllerDelegate: AnyObject {
    func pushMovieDetailViewController(_ movieCode: String, _ movieName: String)
}

protocol MainViewControllerUseCaseDelegate: AnyObject {
    func completeFetchDailyBoxOfficeInformation(_ movieInformationDTOList: [MovieInformationDTO])
    func failFetchDailyBoxOfficeInformation(_ errorDescription: String?)
}

final class MainViewController: UIViewController, CanShowNetworkRequestFailureAlert {
    enum Section {
        case main
    }
    
    private let usecase: MainViewControllerUseCase
    weak var delegate: MainViewControllerDelegate?
    
    private lazy var activityIndicatorView: UIActivityIndicatorView = {
        let activityIndicatorView = UIActivityIndicatorView()
        
        activityIndicatorView.center = view.center
        activityIndicatorView.style = .large
        activityIndicatorView.startAnimating()
        return activityIndicatorView
    }()
    
    private lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        let refreshAction = UIAction { [weak self] _ in
            self?.setUpViewControllerContents()
        }
        
        refreshControl.addAction(refreshAction, for: .valueChanged)
        return refreshControl
    }()
    
    private let compositionalLayout: UICollectionViewCompositionalLayout = {
        var listConfiguration = UICollectionLayoutListConfiguration(appearance: .plain)
        
        listConfiguration.separatorConfiguration.bottomSeparatorInsets = .init(top: 0, leading: 0, bottom: 0, trailing: 0)
        
        let compositionalLayout = UICollectionViewCompositionalLayout.list(using: listConfiguration)
        return compositionalLayout
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: compositionalLayout)
        
        collectionView.delegate = self
        collectionView.refreshControl = refreshControl
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    private var diffableDataSource: UICollectionViewDiffableDataSource<Section, MovieInformationDTO>?
    
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
        setUpViewController()
        setUpViewControllerContents()
        setUpDiffableDataSource()
    }
    
    private func setUpViewController() {
        view.backgroundColor = .systemBackground
        navigationItem.title = usecase.yesterdayDate
    }
    
    private func setUpViewControllerContents() {
        let targetDate = usecase.yesterdayDate.replacingOccurrences(of: "-", with: "")
        
        usecase.fetchDailyBoxOffice(targetDate: targetDate)
    }
    
    private func configureUI() {
        [collectionView, activityIndicatorView].forEach { view.addSubview($0) }
    }
    
    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func setUpDiffableDataSource() {
        let cellResgistration = UICollectionView.CellRegistration<MainCollectionViewCell, MovieInformationDTO> { cell, indexPath, movieInformation in
            
            cell.setUpContent(movieInformation)
        }
        
        diffableDataSource = UICollectionViewDiffableDataSource<Section, MovieInformationDTO>(collectionView: collectionView, cellProvider: { collectionView, indexPath, movieInformation in
            return collectionView.dequeueConfiguredReusableCell(using: cellResgistration, for: indexPath, item: movieInformation)
        })
    }
    
    private func stopRefreshing() {
        self.refreshControl.endRefreshing()
        
        if self.activityIndicatorView.isAnimating {
            self.activityIndicatorView.stopAnimating()
        }
    }
}

// MARK: - MainViewControllerUseCaseDelegate
extension MainViewController: MainViewControllerUseCaseDelegate {
    func completeFetchDailyBoxOfficeInformation(_ movieInformationDTOList: [MovieInformationDTO]) {
        var snapShot = NSDiffableDataSourceSnapshot<Section, MovieInformationDTO>()
        
        snapShot.appendSections([.main])
        snapShot.appendItems(movieInformationDTOList)
        diffableDataSource?.apply(snapShot)
        
        DispatchQueue.main.async {
            self.stopRefreshing()
        }
    }
    
    func failFetchDailyBoxOfficeInformation(_ errorDescription: String?) {
        DispatchQueue.main.async {
            self.stopRefreshing()
            self.showNetworkFailAlert(message: errorDescription, retryFunction: self.setUpViewControllerContents)
        }
    }
}

// MARK: - CollectionView Delegate
extension MainViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movieInformation = diffableDataSource?.snapshot().itemIdentifiers[indexPath.row]
        let movieCode = movieInformation?.movieCode ?? ""
        let movieName = movieInformation?.movieName ?? ""
        
        delegate?.pushMovieDetailViewController(movieCode, movieName)
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}
