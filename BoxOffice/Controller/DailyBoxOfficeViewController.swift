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
    var dataSource: UICollectionViewDiffableDataSource<Section, DailyBoxOffice>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadDailyBoxOffice()
        collectionView.setCollectionViewLayout(creatList(), animated: true)
    }
    
    func configureDataSource() {
        let cellRegistration = UICollectionView.CellRegistration<DailyBoxOfficeCell, DailyBoxOffice> { (cell, indexPath, item) in
            cell.contentView
            cell.rankLabel
            
            let row = indexPath
            
        }
    }
    
    func creatList() -> UICollectionViewCompositionalLayout {
        let configuration = UICollectionLayoutListConfiguration(appearance: .plain)
        
        
        return UICollectionViewCompositionalLayout.list(using: configuration)
    }
    
    private func loadDailyBoxOffice() {
        let api = KobisAPI(service: .dailyBoxOffice)
        var apiProvider = APIProvider()
        apiProvider.target(api: api)
        apiProvider.startLoad(decodingType: DailyBoxOffice.self) { result in
            switch result {
            case .success(let dailyBoxOffice):
                self.dailyBoxOffice = dailyBoxOffice
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

enum Section: CaseIterable {
    case main
}
