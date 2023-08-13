//
//  BoxOfficeMainView.swift
//  BoxOffice
//
//  Created by EtialMoon, Minsup on 2023/08/13.
//

import UIKit

final class BoxOfficeMainView: UIView {
    let boxOfficeCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
        collectionView.register(cellClass: BoxOfficeCollectionViewCell.self)
        
        return collectionView
    }()
    
    let indicatorView = UIActivityIndicatorView()
    
    init() {
        super.init(frame: .zero)
        configureView()
        configureCollectionViewListLayout()        
        backgroundColor = .systemBackground
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func collectionViewReloadItem(indexPaths: [IndexPath]) {
        boxOfficeCollectionView.reloadItems(at: indexPaths)
    }
    
    func collectionViewReloadData() {
        boxOfficeCollectionView.reloadData()
    }
    
    private func configureCollectionViewListLayout() {
        let configuration = UICollectionLayoutListConfiguration(appearance: .plain)
        let layout = UICollectionViewCompositionalLayout.list(using: configuration)
        
        boxOfficeCollectionView.collectionViewLayout = layout
    }
}

// MARK: - Constraints
extension BoxOfficeMainView {
    func configureView() {
        addSubviews()
        setUpConstraints()
    }
    
    private func addSubviews() {
        addSubview(boxOfficeCollectionView)
    }
    
    private func setUpConstraints() {
        boxOfficeCollectionViewConstraints()
        indicatorViewConstraints()
    }
    
    private func boxOfficeCollectionViewConstraints() {
        boxOfficeCollectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            boxOfficeCollectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            boxOfficeCollectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            boxOfficeCollectionView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            boxOfficeCollectionView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor)
        ])
    }
    
    private func indicatorViewConstraints() {
        indicatorView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(indicatorView)
        
        NSLayoutConstraint.activate([
            indicatorView.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            indicatorView.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor),
        ])
    }
}


