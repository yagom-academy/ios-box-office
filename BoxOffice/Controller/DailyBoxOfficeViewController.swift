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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        self.loadDailyBoxOffice()
        collectionView.setCollectionViewLayout(creatList(), animated: true)
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

@available(iOS 14.0, *)
extension DailyBoxOfficeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        return UICollectionViewCell()
    }
}

@available(iOS 14.0, *)
extension DailyBoxOfficeViewController: UICollectionViewDelegate {
    
}
