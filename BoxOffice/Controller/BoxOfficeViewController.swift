//
//  ViewController.swift
//  BoxOffice
//
//  Created by Yetti, Maxhyunm on 2023/07/24.
//

import UIKit

final class BoxOfficeViewController: UIViewController, URLSessionDelegate {
    private var networkingManager: NetworkingManager?
    private var refreshControl = UIRefreshControl()
    private var dataSource: UICollectionViewDiffableDataSource<NetworkNamespace, BoxOfficeEntity.BoxOfficeResult.DailyBoxOffice>?
    
    private let collectionView: UICollectionView = {
        let configuration = UICollectionLayoutListConfiguration(appearance: .plain)
        let layout = UICollectionViewCompositionalLayout.list(using: configuration)
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.register(BoxOfficeRankingCell.self, forCellWithReuseIdentifier: BoxOfficeRankingCell.cellIdentifier)

        return view
    }()
    
    private let indicatorView: UIActivityIndicatorView = {
        let indicatorView = UIActivityIndicatorView()
        indicatorView.style = .large
        indicatorView.translatesAutoresizingMaskIntoConstraints = false
        
        return indicatorView
    }()
    
    private var isLoading: Bool = true {
        willSet(newValue) {
            if newValue == true {
                indicatorView.isHidden = false
                indicatorView.startAnimating()
            } else {
                indicatorView.isHidden = true
                indicatorView.stopAnimating()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        isLoading = true
        setUpUI()
        setUpDate()
        setUpCollectionView()
        setUpDataSource()
        setUpNetwork()
        passFetchedData()
    }
}

extension BoxOfficeViewController {
    private func setUpUI() {
        let safeArea = view.safeAreaLayoutGuide
        
        view.backgroundColor = .systemBackground
        view.addSubview(collectionView)
        view.addSubview(indicatorView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            
            indicatorView.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            indicatorView.centerYAnchor.constraint(equalTo: safeArea.centerYAnchor)
        ])
    }
    
    private func setUpDate() {
        guard let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: Date()) else {
            return
        }
        
        self.title = DateFormatter().formatToString(from: yesterday, with: "YYYY-MM-dd")
    }
}

extension BoxOfficeViewController {
    private func setUpCollectionView() {
        collectionView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
    }
    
    private func setUpDataSource() {
        dataSource = UICollectionViewDiffableDataSource<NetworkNamespace, BoxOfficeEntity.BoxOfficeResult.DailyBoxOffice>(collectionView: self.collectionView) { (collectionView, indexPath, data) -> UICollectionViewCell? in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BoxOfficeRankingCell.cellIdentifier, for: indexPath) as? BoxOfficeRankingCell else {
                return UICollectionViewCell()
            }
            
            cell.setUpLabelText(data)
            
            return cell
        }
    }
    
    private func setUpDataSnapshot(_ data: [BoxOfficeEntity.BoxOfficeResult.DailyBoxOffice]) {
        var snapshot = NSDiffableDataSourceSnapshot<NetworkNamespace, BoxOfficeEntity.BoxOfficeResult.DailyBoxOffice>()
        
        snapshot.appendSections([.boxOffice])
        snapshot.appendItems(data)
        dataSource?.apply(snapshot)
    }
    
    @objc private func refresh() {
        passFetchedData()
    }
}

extension BoxOfficeViewController {
    private func setUpNetwork() {
        let session: URLSession = {
            let configuration = URLSessionConfiguration.default
            configuration.waitsForConnectivity = true
            
            return URLSession(configuration: configuration, delegate: self, delegateQueue: nil)
        }()
        
        networkingManager = NetworkingManager(session)
    }
    
    private func passFetchedData() {
        guard let date = self.title?.replacingOccurrences(of: "-", with: "") else {
            return
        }
        
        let url = String(format: NetworkNamespace.boxOffice.url, NetworkNamespace.apiKey, date)
        
        networkingManager?.load(url) { [weak self] (result: Result<Data, NetworkingError>) in
            switch result {
            case .success(let data):
                do {
                    guard let decodedData: BoxOfficeEntity = try DecodingManager.shared.decode(data) else {
                        break
                    }
                    self?.setUpDataSnapshot(decodedData.boxOfficeResult.dailyBoxOfficeList)
                } catch {
                    print(DecodingError.decodingFailure.description)
                }
            case .failure(let error):
                print(error.description)
            }
            
            DispatchQueue.main.async {
                self?.isLoading = false
                self?.refreshControl.endRefreshing()
            }
        }
    }
}
