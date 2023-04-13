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
    
    private lazy var collectionView = UICollectionView(frame: .zero,
                                                       collectionViewLayout: collectionViewLayout())
    private var dataSource: DataSource!
    private var dailyBoxOffice: DailyBoxOffice?
    private var yesterday: Date {
        Date(timeIntervalSinceNow: 3600 * -24)
    }
    private var targetDate: Date?
    private var collectionViewMode = CollectionViewMode.list
    private var collectionViewModeManager = CollectionViewModeManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureRootView()
        configureNavigationBar()
        configureToolBar()
        configureCollectionView()
        configureDataSource()
        configureRefreshControl()
        loadDailyBoxOffice(date: yesterday)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.isToolbarHidden = false
    }
    
    func changeCollectionViewMode() {
        switch collectionViewMode {
        case .icon:
            collectionViewMode = .list
        case .list:
            collectionViewMode = .icon
        }
        
        collectionView.reloadData()
        collectionView.setCollectionViewLayout(collectionViewLayout(), animated: true) { _ in
            self.collectionView.reloadData()
        }
    }
    
    private func collectionViewLayout() -> UICollectionViewCompositionalLayout {
        let layout = collectionViewModeManager.layout(mode: collectionViewMode)
        
        return layout
    }
    
    private func configureRootView() {
        view.addSubview(collectionView)
        view.backgroundColor = .white
    }
    
    private func configureNavigationBar() {
        let titleText = DateFormatter.shared.string(from: targetDate ?? yesterday,
                                                    dateFormat: "yyyy-MM-dd")
        self.navigationItem.title = titleText
        
        let dateChangeButton = UIBarButtonItem(title: "날짜선택",
                                               style: .plain,
                                               target: self,
                                               action: #selector(showCalendar))
        navigationItem.rightBarButtonItem = dateChangeButton
    }
    
    @objc
    private func showCalendar() {
        let calendarViewController = CalendarViewController(targetDate: targetDate ?? yesterday, delegate: self)
        navigationController?.present(calendarViewController, animated: true)
    }
    
    private func configureToolBar() {
        let titleText = "화면 모드 변경"
        let modeChangeButton = UIBarButtonItem(title: titleText,
                                               style: .plain,
                                               target: self,
                                               action: #selector(showActionSheet))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace,
                                            target: self,
                                            action: nil)
        
        self.navigationController?.isToolbarHidden = false
        self.toolbarItems = [flexibleSpace, modeChangeButton, flexibleSpace]
    }
    
    @objc
    private func showActionSheet() {
        AlertController.showActionSheet(mode: collectionViewMode, to: self)
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
        let listCellRegistration = createCellRegistration(cell: DailyBoxOfficeListCell.self)
        let iconCellRegistration = createCellRegistration(cell: DailyBoxOfficeIconCell.self)

        dataSource = DataSource(collectionView: collectionView) { collectionView, indexPath, itemIdentifier in
            switch self.collectionViewMode {
            case .icon:
                let cell = self.cellForDataSource(collectionView,
                                                  cellRegistration: iconCellRegistration,
                                                  indexPath: indexPath,
                                                  item: itemIdentifier)
                return cell
            case .list:
                let cell = self.cellForDataSource(collectionView,
                                                  cellRegistration: listCellRegistration,
                                                  indexPath: indexPath,
                                                  item: itemIdentifier)
                return cell
            }
        }
    }
    
    private func createCellRegistration<Cell: MovieDataUpdatable>(cell: Cell.Type) -> UICollectionView.CellRegistration<Cell, DailyBoxOfficeMovie> {
        let cellRegistration = UICollectionView.CellRegistration<Cell, DailyBoxOfficeMovie> { cell, indexPath, item in
            
            cell.updateMovieDataIfNeeded(newData: item)
        }
        
        return cellRegistration
    }
    
    private func cellForDataSource<Cell: MovieDataUpdatable>(
        _ collectionView: UICollectionView,
        cellRegistration: UICollectionView.CellRegistration<Cell, DailyBoxOfficeMovie>,
        indexPath: IndexPath,
        item: DailyBoxOfficeMovie
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration,
                                                                for: indexPath,
                                                                item: item)
        cell.snapshotView(afterScreenUpdates: true)
        
        return cell
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
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        collectionView.refreshControl = refreshControl
    }
    
    @objc
    private func refresh() {
        loadDailyBoxOffice(date: targetDate ?? yesterday)
        
        DispatchQueue.main.async {
            self.configureNavigationBar()
        }
    }
    
    private enum Section {
        case main
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
    func calendarViewDidSelect(date: Date) {
        targetDate = date
        let titleText = DateFormatter.shared.string(from: date, dateFormat: "yyyy-MM-dd")
        navigationItem.title = titleText
        loadDailyBoxOffice(date: date)
    }
}
