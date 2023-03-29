//
//  BoxOfficeViewController.swift
//  BoxOffice
//
//  Created by Christy, Hyemory on 2023/03/20.
//

import UIKit

enum Section {
    case main
}

class BoxOfficeViewController: UIViewController {
    var boxOffice: BoxOffice? = nil
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, DailyBoxOfficeItem>!
    let networkManager = NetworkManager()
    
    private let yesterday = Date().addingTimeInterval(3600 * -24)
    
    private lazy var yesterdayLabel: UILabel = {
        let label = UILabel()
        let date = yesterday.applyHyphenDate()
        
        label.text = date
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        navigationItem.title = yesterday.applyHyphenDate()
        
        fetchBoxOffice()
    }
    
    private func fetchBoxOffice() {
        let targetDate = yesterday.applyNotHyphenDate()
        
        networkManager.fetchData(url: URLMaker.dailyBoxOffice.url, type: BoxOffice.self) { result in
            switch result {
            case .success(let data):
                self.boxOffice = data
                DispatchQueue.main.async {
                    self.configureCollectionView()
                    self.configureDataSource()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

extension BoxOfficeViewController {
    func createListLayout() -> UICollectionViewCompositionalLayout {
        let config = UICollectionLayoutListConfiguration(appearance: .plain)
        return UICollectionViewCompositionalLayout.list(using: config)
    }
    
    func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createListLayout())
        view.addSubview(collectionView)
    }
    
    func configureDataSource() {
        guard let items = boxOffice?.result.dailyBoxOfficeList else { return }
        
        let cellRegistration = UICollectionView.CellRegistration<BoxOfficeListCell, DailyBoxOfficeItem> { (cell, indexPath, movie) in
            cell.update(with: movie)
            cell.accessories = [.disclosureIndicator()]
        }
        
        dataSource = UICollectionViewDiffableDataSource<Section, DailyBoxOfficeItem>(collectionView: collectionView) { (collectionView, indexPath, itemIdentifier) -> UICollectionViewCell? in
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
        }
        
        var snapshot = NSDiffableDataSourceSnapshot<Section, DailyBoxOfficeItem>()
        snapshot.appendSections([.main])
        snapshot.appendItems(items)
        dataSource.apply(snapshot)
    }
}
