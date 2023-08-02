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
    
    private func registerCustomCell() {
        collectionView.register(UINib(nibName: "CollectionViewCell", bundle: nil),
                                forCellWithReuseIdentifier: "cell")
    }
    
    private func updateCollectionView() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    private func callAPIManager() {
        APIManager().fetchData(service: .dailyBoxOffice) { [weak self] result in
            let jsonDecoder = JSONDecoder()
            switch result {
            case .success(let data):
                if let decodedData: BoxOffice = jsonDecoder.decodeJSON(data: data) {
                    self?.boxOffice = decodedData
                    self?.updateCollectionView()
                } else {
                    print("Decoding Error")
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}

extension MainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return boxOffice?.boxOfficeResult.dailyBoxOfficeList.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? CollectionViewCell else { return UICollectionViewCell() }
        
        if let boxOfficeData = boxOffice {
            let dailyBoxOffice = boxOfficeData.boxOfficeResult.dailyBoxOfficeList[indexPath.item]
            cell.configureLabels(with: dailyBoxOffice)
            cell.configureFont()
        }
        
        return cell
    }
}

extension MainViewController: UICollectionViewDelegate {
    
}
