//
//  MovieRankingViewController.swift
//  BoxOffice
//
//  Created by Andrew, 레옹아범 on 13/01/23.
//

import UIKit

final class MovieRankingViewController: UIViewController {
    
    // MARK: Propertie
    private var dataManager: DataManager?
    
    // MARK: UI Properties
    private let loadingView = UIActivityIndicatorView()
    private let refreshController = UIRefreshControl()
    private let collectionView = {
        let configuration = UICollectionLayoutListConfiguration(appearance: .plain)
        let layout = UICollectionViewCompositionalLayout.list(using: configuration)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        collectionView.register(MovieRankingCell.self, forCellWithReuseIdentifier: MovieRankingCell.identifier)
        
        return collectionView
    }()
    
    // MARK: DataSource Properties
    private var dataSource: UICollectionViewDiffableDataSource<APIType, InfoObject>?
    private var snapshot = NSDiffableDataSourceSnapshot<APIType, InfoObject>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makeDataManager()
        configureUI()
        startLoadingView()
        makeDataSource()
        configureRefreshController()
        fetchBoxofficeData()
    }
    
    private func fetchBoxofficeData() {
        boxofficeInfo.fetchData { [weak self] result in
            switch result {
            case .success(let data):
                self?.movieItems = data.boxOfficeResult.movies
                DispatchQueue.main.async {
                    self?.applySnapshot()
                    self?.loadingView.stopAnimating()
                }
            case .failure(_):
                return
            }
        }
    }
    
    private func makeDataManager() {
        guard let yesterday = Date.yesterday else {
            return
        }
        dataManager = DataManager(date: yesterday)
    }

    private func startLoadingView() {
        self.loadingView.startAnimating()
    }
    
    private func configureRefreshController() {
        refreshController.addTarget(self, action: #selector(refreshCollectionView), for: .valueChanged)
        collectionView.refreshControl = refreshController
    }
    
    @objc private func refreshCollectionView() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.fetchBoxofficeData()
            self.collectionView.refreshControl?.endRefreshing()
        }
    }
}

// MARK: UI
extension MovieRankingViewController {
    private func configureUI() {
        view.backgroundColor = .systemBackground
        
        configureCollectionViewLayout()
        configureLoadingView()
        
        guard let formattedString = dataManager?.navigationTitleText else {
            return
        }
        
        navigationItem.title = "\(formattedString)"
    }
    
    private func configureLoadingView() {
        loadingView.center = view.center
        loadingView.style = .large
        
        view.addSubview(loadingView)
    }
    
    private func makeDataSource() {
        dataSource = UICollectionViewDiffableDataSource<APIType, InfoObject>(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieRankingCell.identifier, for: indexPath) as? MovieRankingCell else { return UICollectionViewListCell() }
            
            let infoManager = MovieInfoManager(data: itemIdentifier)
            
            cell.updateLabelText(for: infoManager)
            
            return cell
        })
    }
    
    private func applySnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<APIType, InfoObject>()
        
        snapshot.appendSections([apiType])
        snapshot.appendItems(movieItems)
        
        dataSource?.apply(snapshot, animatingDifferences: true)
    }

    private func configureCollectionViewLayout() {
        view.addSubview(collectionView)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

