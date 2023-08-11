//
//  BoxOfficeCollectionView.swift
//  BoxOffice
//
//  Created by EtialMoon, Minsup on 2023/07/31.
//

import UIKit

final class BoxOfficeCollectionViewController: UICollectionViewController {
    var boxOfficeItems: [BoxOfficeItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigation()
        configureCompositionalLayout()
        configureIndicator()
        configureRefreshControl()
        registerCell()
        fetchData()
    }
    
    private func fetchData() {
        Task { [weak self] in
            Indicator.shared.startAnimating()
            await self?.fetchBoxOfficeItems()
            Indicator.shared.stopAnimating()
        }
    }
    
    private func fetchBoxOfficeItems() async {
        do {
            let boxOffice: BoxOffice = try await NetworkManager.fetchData(fetchType: .boxOffice(date: Date.yesterday.networkFormat))
            
            let origin = self.boxOfficeItems
            let new = boxOffice.boxOfficeResult.boxOfficeItems

            if !origin.isEmpty {
                let differentIndexes = zip(origin, new).enumerated().compactMap { index, pair in
                    return pair.0 != pair.1 ? index : nil
                }

                let indexPaths = differentIndexes.map { index in
                    return IndexPath(item: index, section: 0)
                }
                
                self.boxOfficeItems = new
                collectionView.reloadItems(at: indexPaths)
            } else {
                self.boxOfficeItems = new
                collectionView.reloadData()
            }
        } catch {
            let alert = UIAlertController(
                title: "에러",
                message: "\(error.localizedDescription)",
                preferredStyle: .alert
            )
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    private func registerCell() {
        collectionView.register(cellClass: BoxOfficeCollectionViewCell.self)
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
        let indicator = Indicator.shared
        indicator.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(indicator)
        
        NSLayoutConstraint.activate([
            indicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            indicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
    
    private func configureRefreshControl() {
        collectionView.refreshControl = UIRefreshControl()
        collectionView.refreshControl?.addTarget(self, action: #selector(handleRefreshControl), for: .valueChanged)
    }
    
    @objc private func handleRefreshControl() {
        Task { [weak self] in
            await self?.fetchBoxOfficeItems()
            self?.collectionView.refreshControl?.endRefreshing()
        }
    }
}

// MARK: - DataSource
extension BoxOfficeCollectionViewController {
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BoxOfficeCollectionViewCell.identifier, for: indexPath) as? BoxOfficeCollectionViewCell else { return UICollectionViewCell() }
        
        guard let boxOfficeItem = boxOfficeItems[safe: indexPath.row] else {
            return UICollectionViewCell()
        }
        
        cell.configureCell(boxOfficeItem: boxOfficeItem)
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return boxOfficeItems.count
    }
}

extension BoxOfficeCollectionViewController {
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let boxOfficeItem = boxOfficeItems[safe: indexPath.row] else { return }
        
        let movieDetailViewController = MovieDetailViewController(boxOfficeItem: boxOfficeItem)        
        navigationController?.pushViewController(movieDetailViewController, animated: true)
    }
}


