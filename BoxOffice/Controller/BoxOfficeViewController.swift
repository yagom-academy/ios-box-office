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
    private var dataSource: UICollectionViewDiffableDataSource<Section, BoxOfficeEntity.BoxOfficeResult.DailyBoxOffice>?
    
    private let collectionView: UICollectionView = {
        let configuration = UICollectionLayoutListConfiguration(appearance: .plain)
        let layout = UICollectionViewCompositionalLayout.list(using: configuration)
        let view = UICollectionView(frame: .init(), collectionViewLayout: layout)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpDate()
        configureUI()
        setUpNetwork()
        setUpDataSource()
        fetchData()
    }
    
    private func configureUI() {
        let safeArea = view.safeAreaLayoutGuide
        collectionView.register(BoxOfficeRankingCell.self, forCellWithReuseIdentifier: "cell")
        view.backgroundColor = .systemBackground
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            collectionView.leftAnchor.constraint(equalTo: safeArea.leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: safeArea.rightAnchor),
            collectionView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor)
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
                
            case .failure(let error):
                print(error.description)
            }
        }
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

