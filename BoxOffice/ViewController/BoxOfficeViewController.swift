//
//  BoxOfficeViewController.swift
//  BoxOffice
//
//  Created by vetto, brody on 23/03/20.
//
import UIKit

final class BoxOfficeViewController: UIViewController {
    
    enum Section {
        case main
    }
    
    var dataSource: UICollectionViewDiffableDataSource<Section, BoxOfficeItem>! = nil
    var collectionView: UICollectionView! = nil
    var boxOfficeItems: [BoxOfficeItem] = []
    private var snapshot = NSDiffableDataSourceSnapshot<Section, BoxOfficeItem>()
    
    private var refreshControl = UIRefreshControl()
    
    private var yesterday: Date? {
        guard let yesterdayDate = Calendar.current.date(
            byAdding: Calendar.Component.day,
            value: -1,
            to: Date()) else {
            return nil
        }
            
        return yesterdayDate
    }
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.center = self.view.center
        activityIndicator.frame = view.frame
        activityIndicator.style = UIActivityIndicatorView.Style.large
        activityIndicator.startAnimating()
        
        return activityIndicator
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configureHierarchy()
        self.configureDataSource()
        self.collectionView.refreshControl = refreshControl
        self.refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        self.setupUI()
        self.fetchDailyBoxOffice()
    }
    
    func setupUI() {
        guard let yesterday = yesterday?.formatToDate(with: "yyyy-MM-dd") else {
            return
        }
        
        self.navigationItem.title = yesterday
        let appearance = UINavigationBarAppearance()
        self.navigationController?.navigationBar.standardAppearance = appearance
        self.navigationController?.navigationBar.scrollEdgeAppearance = appearance
        self.view.backgroundColor = .white
        self.view.addSubview(activityIndicator)
    }
    
    private func fetchDailyBoxOffice() {
        guard let yesterday = yesterday?.formatToDate(with: "yyyyMMdd") else {
            return
        }
        
        let boxOfficeProvider = BoxOfficeProvider<BoxOfficeAPI>()
        boxOfficeProvider.fetchData(.dailyBoxOffice(date: yesterday),
                                    type: BoxOfficeDTO.self) { result in
            switch result {
            case .success(let data):
                self.boxOfficeItems = data.boxOfficeResult.dailyBoxOfficeList.map { movie in
                    return BoxOfficeItem(rank: movie.rank,
                                         rankIncrement: movie.rankIncrement,
                                         rankOldAndNew: movie.rankOldAndNew,
                                         title: movie.movieName,
                                         audienceCount: movie.audienceCount,
                                         audienceAccumulationCount: movie.audienceAccumulation)
                }
                DispatchQueue.main.async {
                    self.activityIndicator.stopAnimating()
                    self.updateSnapshot()
                }
            case .failure:
                DispatchQueue.main.async {
                    self.activityIndicator.stopAnimating()
                    self.showAlert()
                }
            }
        }
    }
    
    private func showAlert() {
        let alert = UIAlertController(
            title: "에러",
            message: "데이터를 불러올 수 없습니다",
            preferredStyle: .alert
        )
        let okAction = UIAlertAction(title: "확인", style: .default)
        
        alert.addAction(okAction)
        
        present(alert, animated: true)
    }
    
    @objc private func refresh() {
        guard let yesterday = yesterday?.formatToDate(with: "yyyyMMdd") else {
            return
        }
        
        let boxOfficeProvider = BoxOfficeProvider<BoxOfficeAPI>()
        boxOfficeProvider.fetchData(.dailyBoxOffice(date: yesterday),
                                    type: BoxOfficeDTO.self) { result in
            switch result {
            case .success(let data):
                self.boxOfficeItems = data.boxOfficeResult.dailyBoxOfficeList.map { movie in
                    return BoxOfficeItem(rank: movie.rank,
                                         rankIncrement: movie.rankIncrement,
                                         rankOldAndNew: movie.rankOldAndNew,
                                         title: movie.movieName,
                                         audienceCount: movie.audienceCount,
                                         audienceAccumulationCount: movie.audienceAccumulation)
                }
                DispatchQueue.main.async {
                    self.updateSnapshot()
                    self.refreshControl.endRefreshing()
                }
            case .failure:
                DispatchQueue.main.async {
                    self.showAlert()
                    self.refreshControl.endRefreshing()
                }
            }
        }
    }
}

extension BoxOfficeViewController {
    private func createLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .fractionalWidth(0.2))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                         subitems: [item])

        let section = NSCollectionLayoutSection(group: group)

        let layout = UICollectionViewCompositionalLayout(section: section)
        
        return layout
    }
}

extension BoxOfficeViewController {
    private func configureHierarchy() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(collectionView)
    }
    
    private func configureDataSource() {
        let cellRegistration = UICollectionView.CellRegistration<BoxOfficeListCell, BoxOfficeItem> {
            (cell, indexPath, item) in
            cell.item = item
        }
        
        dataSource = UICollectionViewDiffableDataSource<Section, BoxOfficeItem>(collectionView: collectionView) {
            (collectionView: UICollectionView, indexPath: IndexPath, identifier: BoxOfficeItem) -> UICollectionViewCell? in
            
            let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration,
                                                                    for: indexPath,
                                                                    item: identifier)
            
            return cell
        }
    }
    
    private func updateSnapshot() {
        snapshot.deleteAllItems()
        snapshot.appendSections([.main])
        snapshot.appendItems(boxOfficeItems)
        
        dataSource.apply(snapshot, animatingDifferences: false)
    }
}
