//
//  DailyBoxOfficeViewController.swift
//  BoxOffice
//
//  Created by 리지, kokkilE on 2023/03/27.
//

import UIKit

final class DailyBoxOfficeViewController: UIViewController {
    private typealias DataSource = UICollectionViewDiffableDataSource<Section, MovieItem>
    
    private let networkManager = NetworkManager()
    private var boxOfficeEndPoint: BoxOfficeEndPoint?
    private var movieDataSource: DataSource?
    private var movieItems: [MovieItem] = []
    
    private var dateFormatter = DateFormatter()
    private var refreshControl = UIRefreshControl()
    
    lazy private var collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createMovieListLayout())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(collectionView)
        
        configureCollectionView()
        refreshData()
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
    }
    
    @objc private func refreshData() {
        updateDateToViewTitle()
        updateDateToEndPoint()
        fetchDailyBoxOfficeData()
    }
    
    private func configureCollectionView() {
        collectionView.delegate = self
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.register(DailyBoxOfficeCollectionViewCell.self, forCellWithReuseIdentifier: DailyBoxOfficeCollectionViewCell.reuseIdentifier)
        collectionView.refreshControl = refreshControl
    }
    
    private func updateDateToViewTitle() {
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let currentDate = dateFormatter.string(from: Date(timeIntervalSinceNow: -86400))
        
        self.title = currentDate
    }
    
    private func updateDateToEndPoint() {
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
                    self?.applySnapshotToDataSource()
                    self?.refreshControl.endRefreshing()
                }
            }
        }
    }
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
    
    private func applySnapshotToDataSource() {
        typealias Snapshot = NSDiffableDataSourceSnapshot<Section, MovieItem>
        var snapshot = Snapshot()
        snapshot.appendSections([.main])
        snapshot.appendItems(movieItems, toSection: .main)
        
        movieDataSource?.apply(snapshot, animatingDifferences: true)
    }
}

extension DailyBoxOfficeViewController {
    private func createMovieListLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .estimated(44))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .estimated(44))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        return layout
    }
}

extension DailyBoxOfficeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movieName = movieItems[indexPath.item].name
        let movieCode = movieItems[indexPath.item].code
        
        let nextViewcontroller = MovieInformationViewController(movieName: movieName, movieCode: movieCode)
        navigationController?.pushViewController(nextViewcontroller, animated: true)
    }
}

enum Section: Hashable {
    case main
}

struct MovieItem: Hashable {
    init(from movie: DailyBoxOffice.BoxOfficeResult.Movie) {
        self.rank = movie.rank
        self.rankVariance = movie.rankVariance
        self.rankOldAndNew = movie.rankOldAndNew
        self.code = movie.code
        self.name = movie.name
        self.audienceCount = movie.audienceCount
        self.audienceAccumulation = movie.audienceAccumulation
    }
    
    let identifier = UUID()
    let rank: String
    let rankVariance: String
    let rankOldAndNew: String
    let code: String
    let name: String
    let audienceCount: String
    let audienceAccumulation: String
}
