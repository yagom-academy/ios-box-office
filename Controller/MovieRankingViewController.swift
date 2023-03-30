//
//  MovieRankingViewController.swift
//  BoxOffice
//
//  Created by Andrew, 레옹아범 on 13/01/23.
//

import UIKit

final class MovieRankingViewController: UIViewController {
    
    // MARK: Properties
    private let apiType = APIType.boxoffice(Date.yesterday.formatAPIDate())
    private var movieItems: [InfoObject] = []
    private lazy var boxofficeInfo = BoxofficeInfo<DailyBoxofficeObject>(apiType: apiType,
                                                   model: NetworkModel(session: .shared))
    // MARK: UI Properties
    private var collectionView: UICollectionView!
    private let loadingView = UIActivityIndicatorView()
    private let refreshController = UIRefreshControl()
    
    // MARK: DataSource Properties
    private var dataSource: UICollectionViewDiffableDataSource<APIType, InfoObject>!
    private var snapshot = NSDiffableDataSourceSnapshot<APIType, InfoObject>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        startLoadingView()
        makeDataSource()
        fetchBoxofficeData()
        configureRefreshController()
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

    private func startLoadingView() {
        DispatchQueue.main.async {
            self.loadingView.startAnimating()
        }
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
        navigationItem.title = "\(Date.yesterday.formatString())"
        
        configureCollectionView()
        configureCollectionViewLayout()
        configureLoadingView()
    }
    
    private func configureLoadingView() {
        loadingView.center = view.center
        loadingView.style = .large
        
        view.addSubview(loadingView)
    }
}

// MARK: DataSource
extension MovieRankingViewController {
    private func makeDataSource() {
        dataSource = UICollectionViewDiffableDataSource<APIType, InfoObject>(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieRankingCell.identifier, for: indexPath) as? MovieRankingCell else { return UICollectionViewListCell() }
            
            cell.movieItem = itemIdentifier
            
            return cell
        })
        
        snapshot.appendSections([apiType])
    }
    
    private func applySnapshot() {
        snapshot.deleteItems(movieItems)
        
        snapshot.appendItems(movieItems)
        
        dataSource.apply(snapshot, animatingDifferences: true)
    }
}

// MARK: CollectionView UI
extension MovieRankingViewController {
    private func configureCollectionView() {
        let configuration = UICollectionLayoutListConfiguration(appearance: .plain)
        let layout = UICollectionViewCompositionalLayout.list(using: configuration)
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(MovieRankingCell.self, forCellWithReuseIdentifier: MovieRankingCell.identifier)
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

