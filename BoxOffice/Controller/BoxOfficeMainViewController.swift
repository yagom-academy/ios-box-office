//
//  BoxOfficeCollectionView.swift
//  BoxOffice
//
//  Created by EtialMoon, Minsup on 2023/07/31.
//

import UIKit

final class BoxOfficeMainViewController: UIViewController {
    private let boxOfficeMainView = BoxOfficeMainView()
    private var boxOfficeItems: [BoxOfficeItem] = []
    private var task: Task<Void, Never>?
    
    override func loadView() {
        view = boxOfficeMainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        boxOfficeMainView.boxOfficeCollectionView.delegate = self
        boxOfficeMainView.boxOfficeCollectionView.dataSource = self
        configureNavigation()
        configureRefreshControl()
        fetchData()
    }
    
    private func fetchData() {
        Task {
            boxOfficeMainView.indicatorView.startAnimating()
            await self.fetchBoxOfficeItems()
            boxOfficeMainView.indicatorView.stopAnimating()
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
                
                boxOfficeMainView.collectionViewReloadItem(indexPaths: indexPaths)
            } else {
                self.boxOfficeItems = new
                boxOfficeMainView.collectionViewReloadData()
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
    
    private func configureNavigation() {
        navigationItem.title = Date.yesterday.navigationFormat
    }
}

// MARK: - Refresh and indicator
extension BoxOfficeMainViewController {
    private func configureRefreshControl() {
        boxOfficeMainView.boxOfficeCollectionView.refreshControl = UIRefreshControl()
        boxOfficeMainView.boxOfficeCollectionView.refreshControl?.addTarget(self, action: #selector(handleRefreshControl), for: .valueChanged)
    }
    
    @objc private func handleRefreshControl() {
        task?.cancel()        
        task = Task {            
            await self.fetchBoxOfficeItems()
            self.boxOfficeMainView.boxOfficeCollectionView.refreshControl?.endRefreshing()
        }
    }
}

// MARK: - DataSource
extension BoxOfficeMainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BoxOfficeCollectionViewCell.identifier, for: indexPath) as? BoxOfficeCollectionViewCell else { return UICollectionViewCell() }
        
        guard let boxOfficeItem = boxOfficeItems[safe: indexPath.row] else {
            return UICollectionViewCell()
        }
        
        cell.configureCell(boxOfficeItem: boxOfficeItem)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return boxOfficeItems.count
    }
}

extension BoxOfficeMainViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let boxOfficeItem = boxOfficeItems[safe: indexPath.row] else { return }
        
        let movieDetailViewController = MovieDetailViewController(boxOfficeItem: boxOfficeItem)        
        navigationController?.pushViewController(movieDetailViewController, animated: true)
    }
}


