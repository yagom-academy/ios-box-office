//
//  MovieRankingViewController.swift
//  BoxOffice
//
//  Created by Andrew, 레옹아범 on 13/01/23.
//

import UIKit

final class MovieRankingViewController: UIViewController {
    
    private var collectionView: UICollectionView!
    private var dataSource: UICollectionViewDiffableDataSource<APIType, InfoObject>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
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
            return cell
        })
    }
    
}
