//
//  ViewController.swift
//  BoxOffice
//
//  Created by kjs on 13/01/23.
//

import UIKit

class MainViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var loadingActivityView: UIActivityIndicatorView!
    var boxOffice: BoxOffice?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showLodingView()
        assignDataSourceAndDelegate()
        registerCustomCell()
        callAPIManager()
        configureTitle()
        initRefresh()
    }
    
    private func showLodingView() {
        collectionView.isHidden = true
        loadingActivityView.startAnimating()
    }
    
    private func hideLoadingView() {
        self.collectionView.isHidden = false
        self.loadingActivityView.isHidden = true
        self.loadingActivityView.stopAnimating()
    }
    
    private func assignDataSourceAndDelegate() {
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    private func initRefresh() {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(updateData), for: .valueChanged)
        refreshControl.backgroundColor = UIColor.clear
        refreshControl.attributedTitle = NSAttributedString(string: "Loading...", attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemGray, NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 20)])
        self.collectionView.refreshControl = refreshControl
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
    
    @objc private func updateData() {
        callAPIManager()
        NotificationCenter.default.addObserver(self, selector: #selector(reloadCollectionView), name: Notification.Name("completed"), object: nil)
    }
    
    @objc private func reloadCollectionView() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
            self.collectionView.refreshControl?.endRefreshing()
            self.hideLoadingView()
        }
    }
    
    private func callAPIManager() {
        APIManager().fetchData(service: .dailyBoxOffice) { [weak self] result in
            let jsonDecoder = JSONDecoder()
            switch result {
            case .success(let data):
                if let decodedData: BoxOffice = jsonDecoder.decodeJSON(data: data) {
                    self?.boxOffice = decodedData
                    DispatchQueue.main.async {
                        self?.collectionView.reloadData()
                        self?.hideLoadingView()
                    }
                } else {
                    print("Decoding Error")
                }
            case .failure(let error):
                print(error)
            }
            
            NotificationCenter.default.post(name: Notification.Name("completed"), object: nil)
        }
    }
}

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

extension MainViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        guard let pushMovieDetailVC = self.storyboard?.instantiateViewController(withIdentifier: "MovieDetailViewController") else { return }
        
        self.navigationController?.pushViewController(pushMovieDetailVC, animated: true)
    }
}
