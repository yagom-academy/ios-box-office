//
//  BoxOfficeViewController.swift
//  BoxOffice
//
//  Created by Christy, Hyemory on 2023/03/20.
//

import UIKit

final class BoxOfficeViewController: UIViewController {
    enum Section {
        case main
    }
    
    private var boxOffice: BoxOffice?
    private lazy var collectionView = UICollectionView(frame: view.bounds,
                                                       collectionViewLayout: createListLayout())
    private var dataSource: UICollectionViewDiffableDataSource<Section, DailyBoxOfficeItem>?
    private let networkManager = NetworkManager()
    private let dateFormatter = DateFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationItem.title = Date().showYesterdayDate(formatter: dateFormatter, in: .existHyphen)

        fetchBoxOffice()
    }
    
    private func fetchBoxOffice() {
        var api = BoxOfficeURLRequest(service: .dailyBoxOffice)
        let queryName = "targetDt"
        let queryValue = Date().showYesterdayDate(formatter: dateFormatter, in: .notHyphen)
        
        api.addQuery(name: queryName, value: queryValue)
        
        let urlRequest = api.request()
        
        networkManager.fetchData(urlRequest: urlRequest, type: BoxOffice.self) { [weak self] result in
            switch result {
            case .success(let data):
                self?.boxOffice = data
                
                DispatchQueue.main.async {
                    self?.createCollectionView()
                    self?.configureDataSource()
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.displayAlert(from: error)
                }
            }
        }
    }
    
    private func displayAlert(from error: Error) {
        guard let networkingError = error as? NetworkingError else { return }
        let alert = UIAlertController(title: networkingError.description, message: "모리스티에게 문의해 주세요.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "닫기", style: .cancel))
        present(alert, animated: true)
    }
}

// MARK: - BoxOfficeListCell 등록 및 DataSource 설정

extension BoxOfficeViewController {
    private func createListLayout() -> UICollectionViewCompositionalLayout {
        let config = UICollectionLayoutListConfiguration(appearance: .plain)
        
        return UICollectionViewCompositionalLayout.list(using: config)
    }
    
    private func createCollectionView() {
        collectionView = UICollectionView(frame: view.bounds,
                                          collectionViewLayout: createListLayout())
        view.addSubview(collectionView)
        configureRefreshControl()
    }
    
    private func configureDataSource() {
        guard let items = boxOffice?.result.dailyBoxOfficeList else { return }
        
        let cellRegistration = UICollectionView.CellRegistration<BoxOfficeListCell, DailyBoxOfficeItem> {
            (cell, indexPath, item) in
            cell.update(with: item)
            cell.accessories = [.disclosureIndicator()]
        }
        
        dataSource = UICollectionViewDiffableDataSource<Section, DailyBoxOfficeItem>(collectionView: collectionView) {
            (collectionView, indexPath, itemIdentifier) -> UICollectionViewCell? in
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration,
                                                                for: indexPath,
                                                                item: itemIdentifier)
        }
        
        var snapshot = NSDiffableDataSourceSnapshot<Section, DailyBoxOfficeItem>()
        
        snapshot.appendSections([.main])
        snapshot.appendItems(items)
        dataSource?.apply(snapshot)
    }
}

// MARK: - Refresh

extension BoxOfficeViewController {
    private func configureRefreshControl() {
        let refresh = UIRefreshControl()
        
        refresh.addTarget(self, action: #selector(handleRefreshControl), for: .valueChanged)
        collectionView.refreshControl = refresh
    }
    
    @objc private func handleRefreshControl() {
        fetchBoxOffice()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) { [weak self] in
            guard let dateFormatter = self?.dateFormatter else { return }
            
            self?.navigationItem.title = Date().showYesterdayDate(formatter: dateFormatter, in: .existHyphen)
            self?.collectionView.refreshControl?.endRefreshing()
        }
    }
}
