//
//  DailyMovieViewController.swift
//  BoxOffice
//
//  Created by 리지, kokkilE on 2023/03/21.
//

import UIKit

@available(iOS 14.0, *)
final class DailyMovieViewController: UIViewController {
    private typealias DataSource = UICollectionViewDiffableDataSource<Section, MovieItem>
    
    private var networkManager = NetworkManager()
    private var boxOfficeEndPoint: BoxOfficeEndPoint?
    private var movieDataSource: DataSource?
    private var movieItems: [MovieItem] = []
    
    private var refreshControl = UIRefreshControl()

    lazy private var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.register(DailyMovieListCell.self, forCellWithReuseIdentifier: DailyMovieListCell.reuseIdentifier)
        view.addSubview(collectionView)
        
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        refreshData()
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        collectionView.refreshControl = refreshControl
    }
    
    @objc private func refreshData() {
        updateDateToViewTitle()
        updateDateToEndPoint()
        fetchDailyBoxOfficeData()
    }
    
    private func updateDateToViewTitle() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let currentDate = dateFormatter.string(from: Date(timeIntervalSinceNow: -86400))
        
        self.title = currentDate
    }
    
    private func updateDateToEndPoint() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd"
        let currentDate = dateFormatter.string(from: Date(timeIntervalSinceNow: -86400))
        
        boxOfficeEndPoint = BoxOfficeEndPoint.DailyBoxOffice(tagetDate: "\(currentDate)", httpMethod: .get)
    }
    
    private func fetchDailyBoxOfficeData() {
        guard let endPoint = boxOfficeEndPoint else { return }
        
        networkManager.request(endPoint: endPoint, returnType: DailyBoxOffice.self) { [weak self] in
            switch $0 {
            case .failure(let error):
                print(error)
            case .success(let result):
                for index in 0..<result.boxOfficeResult.boxOfficeList.count {
                    self?.movieItems.append(MovieItem.init(from: result.boxOfficeResult.boxOfficeList[index]))
                }
                
                DispatchQueue.main.async {
                    self?.setupDataSource()
                    self?.setupSnapshot()
                    self?.refreshControl.endRefreshing()
                }
            }
        }
    }
}

@available(iOS 14.0, *)
extension DailyMovieViewController {
    private func setupDataSource() {
        let cellRegistration = UICollectionView.CellRegistration<DailyMovieListCell, MovieItem> { (cell, indexPath, item) in
            cell.updateWithItem(item)
            cell.accessories = [.disclosureIndicator()]
        }
        
        movieDataSource = DataSource(collectionView: collectionView) {
            (collectionView: UICollectionView, indexPath: IndexPath, item: MovieItem) -> UICollectionViewCell? in
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: item)
        }
    }
    
    private func setupSnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, MovieItem>()
        snapshot.appendSections([.main])
        snapshot.appendItems(movieItems, toSection: .main)
        
        movieDataSource?.apply(snapshot, animatingDifferences: false)
    }
}

@available(iOS 14.0, *)
extension DailyMovieViewController {
    private func createLayout() -> UICollectionViewLayout {
        let config = UICollectionLayoutListConfiguration(appearance: .plain)
        return UICollectionViewCompositionalLayout.list(using: config)
    }
}

@available(iOS 14.0, *)
extension DailyMovieViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}
