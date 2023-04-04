//
//  DailyBoxOfficeViewController.swift
//  BoxOffice
//
//  Created by Muri, Rowan on 13/01/23.
//

import UIKit

final class DailyBoxOfficeViewController: UIViewController {
    private typealias DataSource = UICollectionViewDiffableDataSource<Section, DailyBoxOfficeMovie>
    private typealias SnapShot = NSDiffableDataSourceSnapshot<Section, DailyBoxOfficeMovie>
    
    private lazy var collectionView = UICollectionView(frame: UIScreen.main.bounds,
                                                       collectionViewLayout: compositionalLayout())
    private var dataSource: DataSource!
    private var dailyBoxOffice: DailyBoxOffice?
    private var yesterday: Date {
        return Date(timeIntervalSinceNow: 3600 * -24)
    }
    private var currentDate: Date?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        LoadingIndicator.showLoading()
        configureRootView()
        configureNavigationBar()
        loadDailyBoxOffice(date: yesterday)
        configureCollectionView()
        configureRefreshControl()
        configureDataSource()
    }
    
    private func configureRootView() {
        view.addSubview(collectionView)
        view.backgroundColor = .white
    }
    
    private func configureNavigationBar() {
        let titleText = DateFormatter.shared.string(from: currentDate ?? yesterday,
                                                    dateFormat: "yyyy-MM-dd")
        title = titleText
        
        let dateChangeButton = UIBarButtonItem(title: "날짜선택",
                                               style: .plain,
                                               target: self,
                                               action: #selector(showCalendar))
        navigationItem.rightBarButtonItem = dateChangeButton
    }
    
    @objc func showCalendar() {
        let calendarViewController = CalendarViewController()
        navigationController?.present(calendarViewController, animated: true)
        calendarViewController.delegate = self
    }
    
    private func loadDailyBoxOffice(date: Date) {
        var api = KobisAPI(service: .dailyBoxOffice)
        let queryName = "targetDt"
        let queryValue = DateFormatter.shared.string(from: date, dateFormat: "yyyyMMdd")
        api.addQuery(name: queryName, value: queryValue)
        
        var apiProvider = APIProvider()
        apiProvider.target(api: api)
        apiProvider.startLoad(decodingType: DailyBoxOffice.self) { result in
            switch result {
            case .success(let dailyBoxOffice):
                self.dailyBoxOffice = dailyBoxOffice
                self.createSnapShot()
                
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
    
    private func compositionalLayout() -> UICollectionViewCompositionalLayout {
        let configuration = UICollectionLayoutListConfiguration(appearance: .plain)
        let layout = UICollectionViewCompositionalLayout.list(using: configuration)
        
        return layout
    }
    
    private func configureDataSource() {
        let cellRegistration = UICollectionView.CellRegistration<DailyBoxOfficeListCell, DailyBoxOfficeMovie> { cell, indexPath, item in
            cell.updateData(with: item)
            cell.accessories = [.disclosureIndicator()]
        }
        
        dataSource = DataSource(collectionView: collectionView) { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration,
                                                                    for: indexPath,
                                                                    item: itemIdentifier)
            return cell
        }
    }
    
    private func createSnapShot() {
        guard let dailyBoxOfficeList = self.dailyBoxOffice?.boxOfficeResult.dailyBoxOfficeList else { return }
        var snapshot = SnapShot()
        snapshot.appendSections([.main])
        snapshot.appendItems(dailyBoxOfficeList)
        
        dataSource.apply(snapshot)
    }
    
    private func configureCollectionView() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
    
    private func configureRefreshControl() {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(handlerRefreshControl), for: .valueChanged)
        collectionView.refreshControl = refreshControl
    }
    
    @objc func handlerRefreshControl() {
        loadDailyBoxOffice(date: currentDate ?? yesterday)
        
        DispatchQueue.main.async {
            self.configureNavigationBar()
        }
    }
    
    private enum Section {
        case main
    }
}

extension DailyBoxOfficeViewController: CalendarViewControllerDelegate {
    func changeTarget(date: Date) {
        currentDate = date
        let titleText = DateFormatter.shared.string(from: date, dateFormat: "yyyy-MM-dd")
        self.navigationItem.title = titleText
        loadDailyBoxOffice(date: date)
    }
}
