//
//  DailyBoxOfficeViewController.swift
//  BoxOffice
//
//  Created by 리지, kokkilE on 2023/03/27.
//

import UIKit

final class DailyBoxOfficeViewController: UIViewController {
    private var networkManager = NetworkManager()
    private var boxOfficeEndPoint: BoxOfficeEndPoint?
    private var refreshControl = UIRefreshControl()
    private typealias DataSource = UICollectionViewDiffableDataSource<Section, DailyBoxOffice.BoxOfficeResult.Movie>
    private var movieDataSource: DataSource?
    private var dailyBoxOffice: DailyBoxOffice?
    lazy private var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createMovieListLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.register(DailyBoxOfficeCollectionViewCell.self, forCellWithReuseIdentifier: DailyBoxOfficeCollectionViewCell.reuseIdentifier)
        view.addSubview(collectionView)
        
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        refreshData()
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        collectionView.refreshControl = refreshControl
        collectionView.delegate = self
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
                self?.dailyBoxOffice = result
                
                DispatchQueue.main.async {
                    self?.setupDataSource()
                    self?.setupSnapshot()
                    self?.refreshControl.endRefreshing()
                }
            }
        }
    }
}

fileprivate enum Section: Hashable {
    case main
}

extension DailyBoxOfficeViewController {
    private func setupDataSource() {
        movieDataSource = DataSource(collectionView: collectionView) { collectionView, indexPath, itemIdentifier in
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: DailyBoxOfficeCollectionViewCell.reuseIdentifier,
                for: indexPath) as? DailyBoxOfficeCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.configure(with: itemIdentifier)
            
            return cell
        }
    }
    
    private func setupSnapshot() {
        typealias Snapshot = NSDiffableDataSourceSnapshot<Section, DailyBoxOffice.BoxOfficeResult.Movie>
        var snapshot = Snapshot()
        snapshot.appendSections([.main])
        if let dailyBoxOffice = self.dailyBoxOffice {
            snapshot.appendItems(dailyBoxOffice.boxOfficeResult.boxOfficeList, toSection: .main)
        }
        movieDataSource?.apply(snapshot, animatingDifferences: true)
    }
}

extension DailyBoxOfficeViewController {
    private func createMovieListLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .fractionalHeight(0.1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .fractionalHeight(1.0))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        return layout
    }
}

extension DailyBoxOfficeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? DailyBoxOfficeCollectionViewCell else { return }
        
        let nextViewcontroller = MovieInformationViewController()
        navigationController?.pushViewController(nextViewcontroller, animated: true)
    }
}
