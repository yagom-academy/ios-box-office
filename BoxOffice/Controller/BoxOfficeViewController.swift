//
//  ViewController.swift
//  BoxOffice
//
//  Created by Yetti, Maxhyunm on 2023/07/24.
//

import UIKit

@available(iOS 14.0, *)
final class BoxOfficeViewController: UIViewController, URLSessionDelegate {
    private var networkingManager: NetworkingManager?
    private var refreshControl = UIRefreshControl()
    private var dataSource: UICollectionViewDiffableDataSource<Section, BoxOfficeEntity.BoxOfficeResult.DailyBoxOffice>?
    
    private let collectionView: UICollectionView = {
        let configuration = UICollectionLayoutListConfiguration(appearance: .plain)
        let layout = UICollectionViewCompositionalLayout.list(using: configuration)
        let view = UICollectionView(frame: .init(), collectionViewLayout: layout)
        view.translatesAutoresizingMaskIntoConstraints = false
        
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
        setUpDate()
        configureUI()
        setUpNetwork()
        setUpDataSource()
        fetchData()
    }
    
    private func configureUI() {
        let safeArea = view.safeAreaLayoutGuide
        collectionView.register(BoxOfficeRankingCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        
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
        
        let dateFormatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateFormat = "YYYY-MM-dd"
            return formatter
        }()
        
        self.title = dateFormatter.string(from: yesterday)
    }
    
    private func setUpDataSnapshot(_ data: [BoxOfficeEntity.BoxOfficeResult.DailyBoxOffice]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, BoxOfficeEntity.BoxOfficeResult.DailyBoxOffice>()
        snapshot.appendSections([.boxOffice])
        snapshot.appendItems(data)
        dataSource?.apply(snapshot)
    }
    
    private func fetchData() {
        guard let date = self.title?.replacingOccurrences(of: "-", with: "") else {
            return
        }
        
        let url = String(format: URLNamespace.boxOffice, URLNamespace.apiKey, date)
        
        networkingManager?.load(url) { [weak self] (result: Result<Data, NetworkingError>) in
            switch result {
            case .success(let data):
                guard let decodedData: BoxOfficeEntity = DecodingManager.shared.decode(data) else {
                    return
                }
                
                self?.setUpDataSnapshot(decodedData.boxOfficeResult.dailyBoxOfficeList)
                
                DispatchQueue.main.async {
                    self?.isLoading = false
                }
                
            case .failure(let error):
                print(error.description)
            }
        }
    }
    
    @objc private func refresh() {
        fetchData()
        refreshControl.endRefreshing()
    }
    
    private func setUpNetwork() {
        let configuration = URLSessionConfiguration.default
        configuration.waitsForConnectivity = true
        let session = URLSession(configuration: configuration, delegate: self, delegateQueue: nil)
        networkingManager = NetworkingManager(session)
    }
    
    private func setUpDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, BoxOfficeEntity.BoxOfficeResult.DailyBoxOffice>(collectionView: self.collectionView) { (collectionView, indexPath, data) -> UICollectionViewCell? in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? BoxOfficeRankingCell else {
                return UICollectionViewCell()
            }
            cell.setUpLabelText(data)
            cell.accessories = [.outlineDisclosure(options: .init(tintColor: .systemGray))]
            
            return cell
        }
    }
}

enum Section {
    case boxOffice
    case movieDetail
}

