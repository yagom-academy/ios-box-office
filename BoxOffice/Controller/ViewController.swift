//
//  ViewController.swift
//  BoxOffice
//
//  Created by kjs on 13/01/23.
//

import UIKit

final class ViewController: UIViewController {
    private enum Section: Hashable {
        case main
    }
    
    private var collectionView : UICollectionView = {
        let configuration = UICollectionLayoutListConfiguration(appearance: .plain)
        let layout = UICollectionViewCompositionalLayout.list(using: configuration)
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: layout
        )
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        return collectionView
    }()
    
    private var dataSource: UICollectionViewDiffableDataSource<Section, DailyBoxOfficeList>?
    private var movieList: [DailyBoxOfficeList] = []
    private let networkManager = NetworkManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        configureDataSource()
        fetchData()
    }
    
    private func configureDataSource() {
        let cellRegistration = UICollectionView.CellRegistration<MovieListCell, DailyBoxOfficeList> { cell, indexPath, item in
            cell.movie = item
            cell.accessories = [.disclosureIndicator()]
        }
        
        dataSource = UICollectionViewDiffableDataSource<Section, DailyBoxOfficeList>(collectionView: collectionView) {
            (collectionView: UICollectionView, indexPath: IndexPath, identifier: DailyBoxOfficeList) -> UICollectionViewCell? in
            let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration,
                                                                    for: indexPath,
                                                                    item: identifier)
            return cell
        }
    }
    
    private func applySnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, DailyBoxOfficeList>()
        snapshot.appendSections([.main])
        snapshot.appendItems(movieList, toSection: .main)
        
        dataSource?.apply(snapshot, animatingDifferences: false)
    }
    
    private func fetchData() {
        let date = Date().yesterday(format: DateFormat.forURL)
        let url = URLManager.dailyBoxOffice(date: date).url
        
        networkManager.fetchData(url: url) { response in
            switch response {
            case .success(let data):
                self.movieList = Decoder().decodeDailyBoxOfficeList(data)
                DispatchQueue.main.async {
                    self.applySnapshot()
                    self.collectionView.refreshControl?.endRefreshing()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    @objc func handleRefreshControl() {
        fetchData()
    }
}

// MARK: Layout

extension ViewController {
    private func configureUI() {
        view.addSubview(collectionView)
        view.backgroundColor = .systemBackground
        self.title = Date().yesterday(format: DateFormat.forTitle)
        
        collectionView.refreshControl = UIRefreshControl()
        collectionView.refreshControl?.addTarget(self, action: #selector(handleRefreshControl), for: .valueChanged)
        
        autoLayout()
    }
    
    private func autoLayout() {
        let safeArea = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}

