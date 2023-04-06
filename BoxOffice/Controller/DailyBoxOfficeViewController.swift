//
//  DailyBoxOfficeViewController.swift
//  BoxOffice
//
//  Created by Muri, Rowan on 13/01/23.
//

import UIKit

final class DailyBoxOfficeViewController: UIViewController {
    private typealias DataSource = UICollectionViewDiffableDataSource<Section, DailyBoxOfficeMovie>
    private typealias Snapshot = NSDiffableDataSourceSnapshot<Section, DailyBoxOfficeMovie>
    
    private lazy var collectionView = UICollectionView(frame: UIScreen.main.bounds,
                                                       collectionViewLayout: collectionViewLayout())
    private var dataSource: DataSource!
    private var dailyBoxOffice: DailyBoxOffice?
    private var yesterday: Date {
        return Date(timeIntervalSinceNow: 3600 * -24)
    }
    private var targetDate: Date?
    private var collectionViewMode = CollectionViewMode.icon
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureRootView()
        configureNavigationBar()
        configureCollectionView()
        configureDataSource()
        loadDailyBoxOffice(date: yesterday)
        configureRefreshControl()
    }
    
    private func configureRootView() {
        view.addSubview(collectionView)
        view.backgroundColor = .white
    }
    
    private func configureNavigationBar() {
        let titleText = DateFormatter.shared.string(from: targetDate ?? yesterday,
                                                    dateFormat: "yyyy-MM-dd")
        title = titleText
        
        let dateChangeButton = UIBarButtonItem(title: "날짜선택",
                                               style: .plain,
                                               target: self,
                                               action: #selector(showCalendar))
        navigationItem.rightBarButtonItem = dateChangeButton
    }
    
    @objc func showCalendar() {
        let calendarViewController = CalendarViewController(targetDate: targetDate ?? yesterday)
        navigationController?.present(calendarViewController, animated: true)
        calendarViewController.delegate = self
    }
    
    private func configureCollectionView() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
        
        collectionView.delegate = self
    }
    
    private func configureDataSource() {
        let cellRegistration = UICollectionView.CellRegistration<DailyBoxOfficeListCell, DailyBoxOfficeMovie> { cell, indexPath, item in
            cell.updateData(with: item)
            cell.accessories = [.disclosureIndicator()]
        }
        
        let cellRegistration2 = UICollectionView.CellRegistration<DailyBoxOfficeIconCell, DailyBoxOfficeMovie> { cell, indexPath, item in
            cell.updateData(with: item)
        }

        dataSource = DataSource(collectionView: collectionView) { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration2,
                                                                    for: indexPath,
                                                                    item: itemIdentifier)
            return cell
        }
    }
    
    private func loadDailyBoxOffice(date: Date) {
        var api = KobisAPI(service: .dailyBoxOffice)
        let queryName = "targetDt"
        let queryValue = DateFormatter.shared.string(from: date, dateFormat: "yyyyMMdd")
        api.addQuery(name: queryName, value: queryValue)
        
        var apiProvider = APIProvider()
        apiProvider.target(api: api)
        
        if collectionView.refreshControl?.isRefreshing == false {
            LoadingIndicator.showLoading()
        }
        
        apiProvider.startLoad(decodingType: DailyBoxOffice.self) { result in
            switch result {
            case .success(let dailyBoxOffice):
                self.dailyBoxOffice = dailyBoxOffice
                self.applySnapshot()
                
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                    self.collectionView.refreshControl?.endRefreshing()
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    AlertController.showAlert(for: error, to: self)
                }
            }
            
            LoadingIndicator.hideLoading()
        }
    }
    
    private func applySnapshot() {
        guard let dailyBoxOfficeList = self.dailyBoxOffice?.boxOfficeResult.dailyBoxOfficeList else { return }
        
        var snapshot = Snapshot()
        snapshot.appendSections([.main])
        snapshot.appendItems(dailyBoxOfficeList)
        
        dataSource.apply(snapshot)
    }
    
    private func configureRefreshControl() {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(handlerRefreshControl), for: .valueChanged)
        collectionView.refreshControl = refreshControl
    }
    
    @objc func handlerRefreshControl() {
        loadDailyBoxOffice(date: targetDate ?? yesterday)
        
        DispatchQueue.main.async {
            self.configureNavigationBar()
        }
    }
    
    private func collectionViewLayout() -> UICollectionViewCompositionalLayout {
        switch collectionViewMode {
        case .list:
            let configuration = UICollectionLayoutListConfiguration(appearance: .plain)
            let layout = UICollectionViewCompositionalLayout.list(using: configuration)
            
            return layout
        case .icon:
            return createIconLayout()
        }
    }
    
    private func createIconLayout() -> UICollectionViewCompositionalLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5),
                                              heightDimension: .fractionalWidth(0.5))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .fractionalHeight(0.25))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                         subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        return layout
    }
    
    private enum Section {
        case main
    }
    
    private enum CollectionViewMode {
        case list
        case icon
    }
}

extension DailyBoxOfficeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let navigationController = self.navigationController
        guard let dailyBoxOfficeMovie = dailyBoxOffice?.boxOfficeResult.dailyBoxOfficeList[safe: indexPath.item]
        else {
            return
        }
        
        let movieCode = dailyBoxOfficeMovie.movieCode
        let movieName = dailyBoxOfficeMovie.movieName
        let movieDetailsViewController = MovieDetailsViewController(movieCode: movieCode,
                                                                    movieName: movieName)
        
        navigationController?.pushViewController(movieDetailsViewController, animated: true)
        
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}

extension DailyBoxOfficeViewController: CalendarViewControllerDelegate {
    func changeTarget(date: Date) {
        targetDate = date
        let titleText = DateFormatter.shared.string(from: date, dateFormat: "yyyy-MM-dd")
        navigationItem.title = titleText
        loadDailyBoxOffice(date: date)
    }
}

