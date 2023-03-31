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
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.style = UIActivityIndicatorView.Style.large
        activityIndicator.center = self.view.center
        
        return activityIndicator
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        activityIndicator.startAnimating()
        loadInitialData()
    }
    
    @objc private func refreshData() {
        fetchDailyBoxOffice { [weak self] in
            guard let self = self else { return }
            
            self.refreshControl.endRefreshing()
        }
    }
    
    private func loadInitialData() {
        fetchDailyBoxOffice { [weak self] in
            guard let self = self else { return }
            
            self.activityIndicator.stopAnimating()
        }
    }
    
    private func registerXib() {
        let nibName = UINib(nibName: BoxOfficeCollectionViewListCell.identifier, bundle: nil)
        collectionView.register(nibName, forCellWithReuseIdentifier: BoxOfficeCollectionViewListCell.identifier)
    }
    
    private func createListLayout() -> UICollectionViewCompositionalLayout {
        var config = UICollectionLayoutListConfiguration(appearance: .plain)
        config.separatorConfiguration.bottomSeparatorInsets = .init(top: 0, leading: 0, bottom: 0, trailing: 0)
        
        return UICollectionViewCompositionalLayout.list(using: config)
    }

    private func configureCollectionView() {
        collectionView.refreshControl = refreshControl
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.collectionViewLayout = createListLayout()
        registerXib()
    }
    
    private func configure() {
        navigationItem.title = YesterdayDateFormatter.text(format: .nonHyphen)
        self.view.addSubview(activityIndicator)
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        configureCollectionView()
    }
    
    private func fetchDailyBoxOffice(completion: @escaping () -> Void) {
        let yesterdayText = YesterdayDateFormatter.text(format: .nonHyphen)
        let endPoint: BoxOfficeEndPoint = .fetchDailyBoxOffice(targetDate: yesterdayText)
        
        networkManager.fetchData(url: endPoint.createURL(), type: BoxOffice.self) {
            [weak self] result in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    self.boxOffice = data
                    self.collectionView.reloadData()
                case .failure(let error):
                    print(error.localizedDescription)
                }
                completion()
            }
        }
    }
}

extension BoxOfficeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let count = boxOffice?.boxOfficeResult.dailyBoxOfficeList.count else { return 0 }
        
        return count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: BoxOfficeCollectionViewListCell.identifier,
            for: indexPath) as? BoxOfficeCollectionViewListCell,
                let item = boxOffice?.boxOfficeResult.dailyBoxOfficeList[safe: indexPath.item] else {
            return UICollectionViewCell()
        }
        
        cell.configure(item: item)
        
        return cell
    }
}

extension BoxOfficeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let movieInfoVC = storyboard?.instantiateViewController(identifier: MovieInfoViewController.identifier, creator: { creator in
            let movieCode = self.boxOffice?.boxOfficeResult.dailyBoxOfficeList[safe: indexPath.item]?.movieCodeText
            let movieName = self.boxOffice?.boxOfficeResult.dailyBoxOfficeList[safe: indexPath.item]?.movieKoreanName
            let viewController = MovieInfoViewController(movieCode: movieCode, movieName: movieName, coder: creator)
            
            return viewController
        }) {
            self.navigationController?.pushViewController(movieInfoVC, animated: true)
        }
    }
}
