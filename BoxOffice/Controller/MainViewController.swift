//
//  ViewController.swift
//  BoxOffice
//
//  Created by kjs on 13/01/23.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var boxOffice: BoxOffice?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        registerCustomCell()
        callAPIManager()
    }
    
    func registerCustomCell() {
        collectionView.register(UINib(nibName: "CollectionViewCell", bundle: nil),
                                forCellWithReuseIdentifier: "cell")
    }
    
    func callAPIManager() {
        APIManager().fetchData(service: .dailyBoxOffice) { [weak self] result in
            let jsonDecoder = JSONDecoder()
            switch result {
            case .success(let data):
                if let decodedData: BoxOffice = jsonDecoder.decodeJSON(data: data) {
                    self?.boxOffice = decodedData
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}

extension MainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? UICollectionViewCell else { return UICollectionViewCell() }
        
        return cell
    }
}

extension MainViewController: UICollectionViewDelegate {
    
}
