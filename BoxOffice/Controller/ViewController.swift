//
//  ViewController.swift
//  BoxOffice
//
//  Created by Muri, Rowan on 13/01/23.
//

import UIKit

final class DailyBoxOfficeViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    
    var dailyBoxOffice: DailyBoxOffice?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        self.loadDailyBoxOffice()
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

extension DailyBoxOfficeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        <#code#>
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        <#code#>
    }
    
    
}

extension DailyBoxOfficeViewController: UICollectionViewDelegate {
    
}
