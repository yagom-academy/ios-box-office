//
//  BoxOfficeViewController.swift
//  BoxOffice
//
//  Created by kaki, harry on 2023/03/20.
//

import UIKit

final class BoxOfficeViewController: UIViewController {
    @IBOutlet private weak var collectionView: UICollectionView!
    
    private let networkManager = NetworkManager()
    private let refreshControl = UIRefreshControl()
    private var boxOffice: BoxOffice?
    
    private var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.style = UIActivityIndicatorView.Style.large
        activityIndicator.startAnimating()
        return activityIndicator
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        registerXib()
        configureCollectionView()
        fetchDailyBoxOffice()
    }
    
    @objc private func refreshData() {
        let endPoint: BoxOfficeEndPoint = .fetchDailyBoxOffice(targetDate: generateYesterdayText())
        
        networkManager.fetchData(url: endPoint.createURL(), type: BoxOffice.self) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    self.boxOffice = data
                    self.collectionView.reloadData()
                case .failure(let error):
                    print(error.localizedDescription)
                }
                self.refreshControl.endRefreshing()
            }
        }
    }
    
    private func registerXib() {
        let nibName = UINib(nibName: BoxOfficeCollectionViewListCell.identifier, bundle: nil)
        collectionView.register(nibName, forCellWithReuseIdentifier: BoxOfficeCollectionViewListCell.identifier)
    }
    
    private func createListLayout() -> UICollectionViewCompositionalLayout {
        let config = UICollectionLayoutListConfiguration(appearance: .plain)
        return UICollectionViewCompositionalLayout.list(using: config)
    }

    private func configureCollectionView() {
        collectionView.refreshControl = refreshControl
        collectionView.backgroundView = activityIndicator
        collectionView.dataSource = self
        collectionView.collectionViewLayout = createListLayout()
        view.addSubview(collectionView)
    }
    
    private func fetchDailyBoxOffice() {
        let endPoint: BoxOfficeEndPoint = .fetchDailyBoxOffice(targetDate: generateYesterdayText())
        
        networkManager.fetchData(url: endPoint.createURL(), type: BoxOffice.self) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    self.boxOffice = data
                    self.collectionView.reloadData()
                case .failure(let error):
                    print(error.localizedDescription)
                }
                self.activityIndicator.stopAnimating()
            }
        }
    }
    
    private func generateYesterdayText() -> String {
        guard let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: Date()) else {
            return ""
        }
        
        let dateFormatter: DateFormatter = {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "YYYYMMdd"
            
            return dateFormatter
        }()
        
        return dateFormatter.string(from: yesterday)
    }
}

extension BoxOfficeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let count = boxOffice?.boxOfficeResult.dailyBoxOfficeList.count else { return 0 }
        
        return count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BoxOfficeCollectionViewListCell.identifier, for: indexPath) as? BoxOfficeCollectionViewListCell else {
            return UICollectionViewCell()
        }
        
        cell.accessories = [
            .disclosureIndicator()
        ]
        
        guard let item = boxOffice?.boxOfficeResult.dailyBoxOfficeList[safe: indexPath.item] else { return  UICollectionViewCell() }
        
        cell.configureCellContent(item: item)
        
        return cell
    }
}
