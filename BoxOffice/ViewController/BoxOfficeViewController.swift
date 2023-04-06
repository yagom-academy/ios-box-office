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
    
    var dataSource: UICollectionViewDiffableDataSource<Section, BoxOfficeItem.ID>! = nil
    var collectionView: UICollectionView! = nil
    var boxOfficeItems: [BoxOfficeItem] = []
    private var snapshot = NSDiffableDataSourceSnapshot<Section, BoxOfficeItem.ID>()
    
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
    
    private let activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.style = UIActivityIndicatorView.Style.large
        activityIndicator.startAnimating()
        
        return activityIndicator
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureHierarchy()
        self.configureDataSource()
        self.setupUI()
        self.fetchDailyBoxOffice()
    }
    
    private func setupUI() {
        guard let yesterday = yesterday?.formatToDate(with: "yyyy-MM-dd") else {
            return
        }
        
        self.navigationItem.title = yesterday
        let appearance = UINavigationBarAppearance()
        self.navigationController?.navigationBar.standardAppearance = appearance
        self.navigationController?.navigationBar.scrollEdgeAppearance = appearance
        
        self.view.addSubview(activityIndicator)
        self.activityIndicator.center = self.view.center
        self.activityIndicator.frame = self.view.frame
        
        self.collectionView.refreshControl = refreshControl
        self.refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
    }
    
    private func fetchDailyBoxOffice() {
        guard let yesterday = yesterday?.formatToDate(with: "yyyyMMdd") else {
            return
        }
        
        let boxOfficeProvider = BoxOfficeProvider<BoxOfficeAPI>()
        boxOfficeProvider.fetchData(.dailyBoxOffice(date: yesterday),
                                    type: BoxOfficeDTO.self) { [weak self] result in
            switch result {
            case .success(let data):
                self?.boxOfficeItems = data.convertToBoxOfficeItems()
                DispatchQueue.main.async {
                    self?.activityIndicator.stopAnimating()
                    self?.updateSnapshot()
                }
            case .failure:
                DispatchQueue.main.async {
                    self?.activityIndicator.stopAnimating()
                    let alertController = AlertManager.shared.showFailureAlert()
                    self?.present(alertController, animated: true)
                }
            }
        }
    }
    
    @objc private func refresh() {
        guard let yesterday = yesterday?.formatToDate(with: "yyyyMMdd") else {
            return
        }
        
        let boxOfficeProvider = BoxOfficeProvider<BoxOfficeAPI>()
        boxOfficeProvider.fetchData(.dailyBoxOffice(date: yesterday),
                                    type: BoxOfficeDTO.self) { [weak self] result in
            switch result {
            case .success(let data):
                self?.boxOfficeItems = data.convertToBoxOfficeItems()
                DispatchQueue.main.async {
                    self?.updateSnapshot()
                    self?.refreshControl.endRefreshing()
                }
            case .failure:
                DispatchQueue.main.async {
                    let alertController = AlertManager.shared.showFailureAlert()
                    self?.present(alertController, animated: true)
                    self?.refreshControl.endRefreshing()
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
        collectionView.delegate = self
        view.addSubview(collectionView)
    }
    
    private func configureDataSource() {
        let cellRegistration = UICollectionView.CellRegistration<BoxOfficeListCell, BoxOfficeItem> {
            (cell, indexPath, item) in
            cell.item = item
        }
        
        dataSource = UICollectionViewDiffableDataSource<Section, BoxOfficeItem.ID>(collectionView: collectionView) {
            (collectionView: UICollectionView, indexPath: IndexPath, identifier: BoxOfficeItem.ID) -> UICollectionViewCell? in
            
            let boxOfficeItem = self.boxOfficeItems.filter { $0.id == identifier }.first
            
            let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration,
                                                                    for: indexPath,
                                                                    item: boxOfficeItem)
            
            return cell
        }
    }
    
    private func updateSnapshot() {
        snapshot.deleteAllItems()
        snapshot.appendSections([.main])
        snapshot.appendItems(boxOfficeItems.map { $0.id })
        
        dataSource.apply(snapshot, animatingDifferences: false)
    }
}

extension BoxOfficeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedTitle = boxOfficeItems[indexPath.row].title
        let selectedCode = boxOfficeItems[indexPath.row].code
        let movieDetailViewController = MovieDetailViewController(movieName: selectedTitle,
                                                                  movieCode: selectedCode)
        self.navigationController?.pushViewController(movieDetailViewController, animated: true)
    }
}
