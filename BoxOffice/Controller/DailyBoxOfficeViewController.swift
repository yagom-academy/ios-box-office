//
//  DailyBoxOfficeViewController.swift
//  BoxOffice
//
//  Created by Muri, Rowan on 13/01/23.
//

import UIKit

@available(iOS 14.0, *)
final class DailyBoxOfficeViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    
    var dailyBoxOffice: DailyBoxOffice?
    var dataSource: UICollectionViewDiffableDataSource<Section, DailyBoxOfficeMovie>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadDailyBoxOffice()
        collectionView.setCollectionViewLayout(creatList(), animated: true)
    }
    
    func configureDataSource() {
        let cellRegistration = UICollectionView.CellRegistration<DailyBoxOfficeCell, DailyBoxOfficeMovie> { (cell, indexPath, item) in
            
            cell.update(with: item)
            cell.accessories = [.disclosureIndicator()]
        }
        
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView) {
            (collectionView, indexPath, itemIdentifier) -> UICollectionViewCell? in
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
        }
        
        var snapshot = NSDiffableDataSourceSnapshot<Section, DailyBoxOfficeMovie>()
        snapshot.appendSections([.main])
        snapshot.appendItems((dailyBoxOffice?.boxOfficeResult.dailyBoxOfficeList)!)
        dataSource.apply(snapshot)
    }
    
    func creatList() -> UICollectionViewCompositionalLayout {
        let configuration = UICollectionLayoutListConfiguration(appearance: .plain)
        
        
        return UICollectionViewCompositionalLayout.list(using: configuration)
    }
    
    private func loadDailyBoxOffice() {
        var api = KobisAPI(service: .dailyBoxOffice)
        api.addQuery(name: "targetDt", value: "20230101")
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
}

enum Section: CaseIterable {
    case main
}
