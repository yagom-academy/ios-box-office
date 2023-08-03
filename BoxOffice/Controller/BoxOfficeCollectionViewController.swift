//
//  BoxOfficeCollectionView.swift
//  BoxOffice
//
//  Created by EtialMoon, Minsup on 2023/07/31.
//

import SwiftUI

class BoxOfficeCollectionViewController: UICollectionViewController {
    var boxOfficeItems: [BoxOfficeItem] = []
    let indicator = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigation()
        configureCompositionalLayout()
        configureIndicator()
        configureRefreshControl()
        registerCell()
        
        Task {
            indicator.startAnimating()
            await fetchBoxOfficeItems()
            indicator.stopAnimating()
        }
    }
    
    private func fetchBoxOfficeItems() async {
        do {
            let boxOffice: BoxOffice = try await NetworkManager.fetchData(fetchType: .boxOffice(date: Date.yesterday.networkFormat))
            self.boxOfficeItems = boxOffice.boxOfficeResult.boxOfficeItems
            
            collectionView.reloadData()
        } catch {
            //TODO: 알럿띄우기
        }
    }
    
    private func registerCell() {
        collectionView.register(BoxOfficeCollectionViewCell.self, forCellWithReuseIdentifier: BoxOfficeCollectionViewCell.identifier)
    }
    
    private func configureNavigation() {
        navigationItem.title = Date.yesterday.navigationFormat
    }
    
    private func configureCompositionalLayout() {
        let config = UICollectionLayoutListConfiguration(appearance: .plain)
        let layout = UICollectionViewCompositionalLayout.list(using: config)
        
        collectionView.collectionViewLayout = layout
    }
}

// MARK: - Refresh and indicator

extension BoxOfficeCollectionViewController {
    private func configureIndicator() {
        indicator.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(indicator)
        
        NSLayoutConstraint.activate([
            indicator.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            indicator.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            indicator.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            indicator.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
        ])
    }
    
    private func configureRefreshControl() {
        collectionView.refreshControl = UIRefreshControl()
        collectionView.refreshControl?.addTarget(self, action: #selector(handleRefreshControl), for: .valueChanged)
    }
    
    @objc private func handleRefreshControl() {
        Task {
            await fetchBoxOfficeItems()
            collectionView.refreshControl?.endRefreshing()
        }
    }
}

// MARK: - DataSource
extension BoxOfficeCollectionViewController {
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BoxOfficeCollectionViewCell.identifier, for: indexPath) as! BoxOfficeCollectionViewCell
        
        let boxOfficeItem = boxOfficeItems[indexPath.row]
        
        cell.configureCell(boxOfficeItem: boxOfficeItem)
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return boxOfficeItems.count
    }
}
