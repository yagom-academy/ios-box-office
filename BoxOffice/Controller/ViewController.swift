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
    
    private var dataSource: UICollectionViewDiffableDataSource<Section, DailyBoxOfficeList>!
    private var movieList: [DailyBoxOfficeList] = []
    
    enum Section: Hashable {
        case main
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        autoLayout()
        configureDataSource()
        fetchData()
    }
    
    private func configureDataSource() {
        let cellRegistration = UICollectionView.CellRegistration<MovieListCell, DailyBoxOfficeList> { cell, indexPath, item in
            cell.movie = item
            cell.accessories = [.disclosureIndicator()]
        }
        
        dataSource = UICollectionViewDiffableDataSource<Section, DailyBoxOfficeList>(collectionView: collectionView) {
            (collectionView: UICollectionView, indexPath: IndexPath, identifier: DailyBoxOfficeList) -> UICollectionViewCell? in
            let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration,
                                                                    for: indexPath,
                                                                    item: identifier)
            return cell
        }
    }
    
    private func applySnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, DailyBoxOfficeList>()
        snapshot.appendSections([.main])
        snapshot.appendItems(movieList, toSection: .main)

        dataSource.apply(snapshot, animatingDifferences: false)
    }
    
    private func fetchData() {
        let networkManager = NetworkManager()
        let date = yesterday(format: DateFormat.forURL)
        let url = URLManager.dailyBoxOffice(date: date).url
        
        networkManager.fetchData(url: url) { response in
            switch response {
            case .success(let data):
                self.decode(data)
                DispatchQueue.main.async {
                    self.applySnapshot()
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
                    self.collectionView.refreshControl?.endRefreshing()
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
    
    private func yesterday(format: String) -> String {
        let yesterday = Date(timeIntervalSinceNow: DateFormat.forTimeInterval)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        
        guard let dateString = dateFormatter.string(for: yesterday) else {
            return DateFormat.empty
        }
        
        return dateString
    }
}

extension ViewController {
    private func configureUI() {
        view.backgroundColor = .systemBackground
        self.title = yesterday(format: DateFormat.forTitle)
        
        collectionView.refreshControl = UIRefreshControl()
        collectionView.refreshControl?.addTarget(self, action: #selector(handleRefreshControl), for: .valueChanged)
    }
    
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
                                                 
    @objc func handleRefreshControl() {
        fetchData()
    }
}

