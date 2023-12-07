//
//  ViewController.swift
//  BoxOffice
//
//  Created by kjs on 13/01/23.
//

import UIKit

class ViewController: UIViewController {
    private var collectionView : UICollectionView = {
        let configuration = UICollectionLayoutListConfiguration(appearance: .plain)
        let layout = UICollectionViewCompositionalLayout.list(using: configuration)
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: layout
        )
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        return collectionView
    }()
    
    private var yesterday: String {
         let yesterday = Date(timeIntervalSinceNow: -86400)
         let dateFormatter = DateFormatter()
         dateFormatter.dateFormat = "yyyyMMdd"
         
         guard let dateString = dateFormatter.string(for: yesterday) else {
             return ""
         }
         
         return dateString
     }
    
    private var dataSource: UICollectionViewDiffableDataSource<Section, DailyBoxOfficeList>!
    private var movieList: [DailyBoxOfficeList] = []
    
    enum Section: Hashable {
        case main
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        autoLayout()
        fetchData()
    }
    
    private func configureDataSource() {
        let cellRegistration = UICollectionView.CellRegistration<MovieListCell, DailyBoxOfficeList> { cell, indexPath, item in
            cell.movie = item
        }
        
        dataSource = UICollectionViewDiffableDataSource<Section, DailyBoxOfficeList>(collectionView: collectionView) {
            (collectionView: UICollectionView, indexPath: IndexPath, identifier: DailyBoxOfficeList) -> UICollectionViewCell? in
            let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration,
                                                                    for: indexPath,
                                                                    item: identifier)
            return cell
        }
        
        var snapshot = NSDiffableDataSourceSnapshot<Section, DailyBoxOfficeList>()
        snapshot.appendSections([.main])
        snapshot.appendItems(movieList, toSection: .main)

        dataSource.apply(snapshot, animatingDifferences: false)
    }
    
    private func fetchData() {
        let networkManager = NetworkManager()
        let date = yesterday
        let url = URLManager.dailyBoxOffice(date: date).url
        
        networkManager.fetchData(url: url) { response in
            switch response {
            case .success(let data):
                self.decode(data)
                DispatchQueue.main.async {
                    self.configureDataSource()
                    self.collectionView.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func decode(_ data: Data) {
        do {
            movieList = try Decoder().parse(
                data: data,
                type: Movie.self
            ).boxOfficeResult.dailyBoxOfficeList
        } catch {
            print(error.localizedDescription)
        }
    }
}

extension ViewController {
    private func autoLayout() {
        view.addSubview(collectionView)
        
        let safeArea = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}

