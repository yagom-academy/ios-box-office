//
//  DailyBoxOfficeViewController.swift
//  BoxOffice
//
//  Created by Muri, Rowan on 13/01/23.
//

import UIKit

final class DailyBoxOfficeViewController: UIViewController {
    private var collectionView: UICollectionView!
    private var dataSource: UICollectionViewDiffableDataSource<Section, DailyBoxOfficeMovie>!
    private var dailyBoxOffice: DailyBoxOffice?
    private var yesterday = Date(timeIntervalSinceNow: -(3600 * 24))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationTitle()
        loadDailyBoxOffice()
        configureCollectionView()
        configureRefreshControl()
    }
    
    private func setNavigationTitle() {
        let title = DateFormatter(dateFormat: "yyyy-MM-dd").string(from: yesterday)
        self.title = title
    }
    
    private func configureCollectionView() {
        let collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createListLayout())
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
        
        self.collectionView = collectionView
    }
    
    private func createListLayout() -> UICollectionViewCompositionalLayout {
        let configuration = UICollectionLayoutListConfiguration(appearance: .plain)
        
        return UICollectionViewCompositionalLayout.list(using: configuration)
    }
    
    private func configureDataSource() {
        let cellRegistration = UICollectionView.CellRegistration<DailyBoxOfficeCell, DailyBoxOfficeMovie> { (cell, indexPath, item) in
            cell.update(with: item)
            cell.accessories = [.disclosureIndicator()]
        }
        
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView) {
            (collectionView, indexPath, itemIdentifier) -> UICollectionViewCell? in
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
        }
        
        guard let dailyBoxOffice = self.dailyBoxOffice else { return }
        
        var snapshot = NSDiffableDataSourceSnapshot<Section, DailyBoxOfficeMovie>()
        snapshot.appendSections([.main])
        snapshot.appendItems(dailyBoxOffice.boxOfficeResult.dailyBoxOfficeList)
        
        dataSource.apply(snapshot)
    }
    
    private func loadDailyBoxOffice() {
        var api = KobisAPI(service: .dailyBoxOffice)
        let targetDate = DateFormatter(dateFormat: "yyyyMMdd").string(from: yesterday)
        api.addQuery(name: "targetDt", value: targetDate)
        
        var apiProvider = APIProvider()
        apiProvider.target(api: api)
        apiProvider.startLoad(decodingType: DailyBoxOffice.self) { result in
            switch result {
            case .success(let dailyBoxOffice):
                self.dailyBoxOffice = dailyBoxOffice
                print(dailyBoxOffice)
                DispatchQueue.main.async {
                    self.configureDataSource()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func configureRefreshControl() {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(handlerRefreshControl), for: .valueChanged)
        collectionView.refreshControl = refreshControl
    }
    
    @objc func handlerRefreshControl() {
        loadDailyBoxOffice()
        self.collectionView.reloadData()
        
        DispatchQueue.main.async {
            self.collectionView.refreshControl?.endRefreshing()
        }
    }
    
    private enum Section: CaseIterable {
        case main
    }
}
