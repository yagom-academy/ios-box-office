//
//  MovieRankingViewController.swift
//  BoxOffice
//
//  Created by Andrew, 레옹아범 on 13/01/23.
//

import UIKit

final class MovieRankingViewController: UIViewController {
    
    private let apiType = APIType.boxoffice("20230328")
    private var movieItems: [InfoObject] = []
    private var collectionView: UICollectionView!
    private var dataSource: UICollectionViewDiffableDataSource<APIType, InfoObject>!
    private var snapshot = NSDiffableDataSourceSnapshot<APIType, InfoObject>()
    private lazy var boxofficeInfo = BoxofficeInfo<DailyBoxofficeObject>(apiType: apiType,
                                                   model: NetworkModel(session: .shared))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        makeDataSource()
        fetchBoxofficeData()
    }
    
    private func fetchBoxofficeData() {
        boxofficeInfo.fetchData { [weak self] result in
            switch result {
            case .success(let data):
//                print(data)
                self?.movieItems = data.boxOfficeResult.movies
                DispatchQueue.main.async {
                    self?.applySnapshot()
                }
            case .failure(_):
                return
            }
        }
    }
    
    private func configureCollectionView() {
        let configuration = UICollectionLayoutListConfiguration(appearance: .plain)
        let layout = UICollectionViewCompositionalLayout.list(using: configuration)
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(MovieRankingCell.self, forCellWithReuseIdentifier: MovieRankingCell.identifier)
    }
    
    private func configureCollectionViewLayout() {
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func configureUI() {
        view.backgroundColor = .systemBackground
        navigationItem.title = "2023-03-29"
        configureCollectionView()
        configureCollectionViewLayout()
    }
    
    private func makeDataSource() {
        dataSource = UICollectionViewDiffableDataSource<APIType, InfoObject>(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieRankingCell.identifier, for: indexPath) as? MovieRankingCell else { return UICollectionViewListCell() }
            
            cell.movieItem = itemIdentifier
            
            return cell
        })
    }
    
    private func applySnapshot() {
        snapshot.appendSections([apiType])
        snapshot.appendItems(movieItems)
        
        dataSource.apply(snapshot, animatingDifferences: true)
    }
}
