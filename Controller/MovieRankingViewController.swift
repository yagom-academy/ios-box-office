//
//  MovieRankingViewController.swift
//  BoxOffice
//
//  Created by Andrew, 레옹아범 on 13/01/23.
//

import UIKit

final class MovieRankingViewController: UIViewController {
    
    // MARK: Propertie
    private var dataManager = {
        guard let yesterday = Date.yesterday else {
            return RankingManager(date: Date())
        }
        
        return RankingManager(date: yesterday)
    }()
    
    // MARK: UI Properties
    private let loadingView = UIActivityIndicatorView()
    private let refreshController = UIRefreshControl()
    private var collectionView: UICollectionView?
    
    // MARK: DataSource Properties
    private var dataSource: UICollectionViewDiffableDataSource<APIType, InfoObject>?
    private var snapshot = NSDiffableDataSourceSnapshot<APIType, InfoObject>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        startLoadingView()
        makeDataSource()
        configureRefreshController()
        fetchBoxofficeData()
    }
    
    private func fetchBoxofficeData() {
        dataManager.fetchRanking { [weak self] result in
            switch result {
            case .success(_):
                DispatchQueue.main.async {
                    self?.applySnapshot()
                    self?.stopLoadingView()
                    self?.collectionView?.refreshControl?.endRefreshing()
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.presentErrorAlert(error: error, title: "박스오피스")
                }
            }
        }
    }

    private func startLoadingView() {
        self.loadingView.startAnimating()
    }
    
    private func stopLoadingView() {
        self.loadingView.stopAnimating()
    }
    
    private func configureRefreshController() {
        refreshController.addTarget(self, action: #selector(refreshCollectionView), for: .valueChanged)
        collectionView?.refreshControl = refreshController
    }
    
    @objc private func refreshCollectionView() {
        self.fetchBoxofficeData()
    }
}

// MARK: Delegate
extension MovieRankingViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let nextViewController = MovieDetailViewController()
        
        nextViewController.movieName = dataManager.movieItems[indexPath.row].name
        nextViewController.movieCode = dataManager.movieItems[indexPath.row].code
        
        navigationController?.pushViewController(nextViewController, animated: true)
    }
}

// MARK: UI
extension MovieRankingViewController {
    private func configureUI() {
        view.backgroundColor = .systemBackground
        
        let layout = makeCollectionViewListLayout()
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        configureCollectionViewLayout()
        configureLoadingView()
        
        navigationItem.title = "\(dataManager.navigationTitleText)"
    }
    
    private func configureLoadingView() {
        loadingView.center = view.center
        loadingView.style = .large
        
        view.addSubview(loadingView)
    }
    
    func makeCollectionViewListLayout() -> UICollectionViewCompositionalLayout {
        let configuration = UICollectionLayoutListConfiguration(appearance: .plain)
        let layout = UICollectionViewCompositionalLayout.list(using: configuration)
        
        return layout
    }
    
    private func makeDataSource() {
        guard let collectionView = collectionView else { return }
        
        dataSource = UICollectionViewDiffableDataSource<APIType, InfoObject>(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieRankingCell.identifier, for: indexPath) as? MovieRankingCell else { return UICollectionViewListCell() }
            
            let uiModel = CellUIModel(data: itemIdentifier)
            
            cell.updateLabelText(for: uiModel)
            
            return cell
        })
    }
    
    private func applySnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<APIType, InfoObject>()
        
        snapshot.appendSections([dataManager.apiType])
        snapshot.appendItems(dataManager.movieItems)
        
        dataSource?.apply(snapshot, animatingDifferences: true)
    }

    private func configureCollectionViewLayout() {
        guard let collectionView = collectionView else { return }
        
        view.addSubview(collectionView)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self
        collectionView.register(MovieRankingCell.self, forCellWithReuseIdentifier: MovieRankingCell.identifier)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
