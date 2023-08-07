//
//  MainViewController.swift
//  BoxOffice
//
//  Created by Zion, Hemg on 13/01/23.
//

import UIKit

enum Section {
    case main
}

protocol MainViewControllerUseCaseDelegate: AnyObject {
    func completeFetchDailyBoxOfficeInformation(_ movieInformationDTOList: [MovieInformationDTO])
    func failFetchDailyBoxOfficeInformation(_ errorDescription: String?)
}

final class MainViewController: UIViewController, CanShowNetworkRequestFailureAlert {
    private let usecase: MainViewControllerUseCase
    
    private lazy var activityIndicatorView: UIActivityIndicatorView = {
        let activityIndicatorView = UIActivityIndicatorView()
        
        activityIndicatorView.center = view.center
        activityIndicatorView.style = .large
        activityIndicatorView.startAnimating()
        return activityIndicatorView
    }()
    
    private lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        
        refreshControl.addTarget(self, action: #selector(setUpViewControllerContents), for: .valueChanged)
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
        
        collectionView.dataSource = diffableDataSource
        collectionView.refreshControl = refreshControl
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(MainCollectionViewCell.self, forCellWithReuseIdentifier: MainCollectionViewCell.reuseIdentifier)
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
    
    @objc private func setUpViewControllerContents() {
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
        diffableDataSource = UICollectionViewDiffableDataSource<Section, MovieInformationDTO>(collectionView: collectionView, cellProvider: { collectionView, indexPath, movieInformation in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainCollectionViewCell.reuseIdentifier, for: indexPath) as? MainCollectionViewCell else {
                return UICollectionViewCell()
            }
            
            cell.setUpContent(movieInformation)
            return cell
        })
    }
}

// MARK: - MainViewControllerUseCaseDelegate
extension MainViewController: MainViewControllerUseCaseDelegate {
    func completeFetchDailyBoxOfficeInformation(_ movieInformationDTOList: [MovieInformationDTO]) {
        var snapShot = NSDiffableDataSourceSnapshot<Section, MovieInformationDTO>()
        
        snapShot.appendSections([.main])
        snapShot.appendItems(movieInformationDTOList)
        DispatchQueue.main.async {
            self.diffableDataSource?.apply(snapShot)
            self.refreshControl.endRefreshing()
            
            if self.activityIndicatorView.isAnimating { self.activityIndicatorView.stopAnimating() }
        }
    }
    
    func failFetchDailyBoxOfficeInformation(_ errorDescription: String?) {
        DispatchQueue.main.async {
            self.refreshControl.endRefreshing()
            self.showNetworkFailAlert(message: errorDescription, retryFunction: self.setUpViewControllerContents)
            
            if self.activityIndicatorView.isAnimating { self.activityIndicatorView.stopAnimating() }
        }
    }
}
