//
//  ViewController.swift
//  BoxOffice
//
//  Created by kjs on 13/01/23.
//

import UIKit

@available(iOS 14.0, *)
class MainViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var loadingActivityView: UIActivityIndicatorView!
    
    var boxOffice: BoxOffice?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.isHidden = true
        loadingActivityView.startAnimating()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        registerCustomCell()
        callAPIManager()
        configureTitle()
        
        collectionView.refreshControl = UIRefreshControl()
        collectionView.refreshControl?.addTarget(self, action: #selector(updateCollectionView), for: .valueChanged)
    }
    
    private func configureTitle() {
        let dateProvider = DateProvider()
        guard let yesterday = dateProvider.updateYesterday(.viewTitle) else {
            return
        }
        
        self.navigationItem.title = "\(yesterday)"
    }
    
    private func registerCustomCell() {
        collectionView.register(UINib(nibName: "CollectionViewListCell", bundle: nil),
                                forCellWithReuseIdentifier: "cell")
    }
    
    @objc private func updateCollectionView() {
        collectionView.isHidden = false
        loadingActivityView.stopAnimating()
        loadingActivityView.isHidden = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.collectionView.reloadData()
            self.collectionView.refreshControl?.endRefreshing()
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

@available(iOS 14.0, *)
extension MainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return boxOffice?.boxOfficeResult.dailyBoxOfficeList.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? CollectionViewListCell else { return UICollectionViewListCell() }
        
        if let boxOfficeData = boxOffice {
            let dailyBoxOffice = boxOfficeData.boxOfficeResult.dailyBoxOfficeList[indexPath.item]
            cell.configureLabels(with: dailyBoxOffice)
            cell.configureFont()
            cell.accessories = [.disclosureIndicator()]
        }
        
        return cell
    }
}

@available(iOS 14.0, *)
extension MainViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        guard let pushMovieDetailVC = self.storyboard?.instantiateViewController(withIdentifier: "MovieDetailViewController") else { return }
        
        self.navigationController?.pushViewController(pushMovieDetailVC, animated: true)
    }
}
