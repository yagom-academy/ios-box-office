//
//  ViewController.swift
//  BoxOffice
//
//  Created by Seoyeon Hong on 2023/03/22.
//

import UIKit

final class ViewController: UIViewController {
    
    private var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<ListSection, ListItem>!
    
    let provider = APIProvider.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureHierarchy()
        configureDataSource()
        fetchBoxOfficeData()
        configureRefreshControl()
    }

    func fetchBoxOfficeData() {
        guard let yesterday = createFormattedDate(dateFormat: "yyyyMMdd") else { return }
        provider.performRequest(api: .boxOffice(date: yesterday)) { requestResult in
            switch requestResult {
            case .success(let data):
                do {
                    let boxOfficeItem: BoxOfficeItem = try JSONConverter.shared.decodeData(data, T: BoxOfficeItem.self)
                    let myMovielists = boxOfficeItem.boxOfficeResult.dailyBoxOfficeList.map { ListItem(rank: $0.rank, rankInten: $0.rankInten, rankOldandNew: $0.rankOldAndNew.rawValue, movieName: $0.movieName, audienceCount: $0.audienceCount, audienceAcc: $0.audienceAcc) }
                    DispatchQueue.main.async {
                        _ = self.makeSnapshot(with: myMovielists)
                    }
                } catch let error as NetworkError {
                    print(error.description)
                } catch {
                    print("Unexpected error: \(error)")
                }
                
            case .failure(let error):
                print(error)
            }
            DispatchQueue.main.async {
                self.collectionView.refreshControl?.endRefreshing()
            }
        }
    }
    
    func createFormattedDate(dateFormat: String) -> String? {
        let dateFormatter = DateFormatter()
        let today = Date()
        dateFormatter.dateFormat = dateFormat
        guard let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: today) else { return nil }
        return dateFormatter.string(from: yesterday)
    }
    
    // MARK: - CollectionView
    private func createLayout() -> UICollectionViewLayout {
        let config = UICollectionLayoutListConfiguration(appearance: .plain)
        return UICollectionViewCompositionalLayout.list(using: config)
    }
    
    private func configureHierarchy() {
        let layout = createLayout()
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(collectionView)
        collectionView.delegate = self
    }
    
    private func configureViewController() {
        guard let yesterday = createFormattedDate(dateFormat: "yyyy-MM-dd") else { return }
        navigationController?.navigationBar.topItem?.title = yesterday
        navigationController?.navigationBar.titleTextAttributes = [.font: UIFont.systemFont(ofSize: 18, weight: .bold)]
    }
    
    private func configureRefreshControl() {
        collectionView.refreshControl = UIRefreshControl()
        collectionView.refreshControl?.addTarget(self, action: #selector(handleRefreshControl), for: .valueChanged)
        collectionView.refreshControl?.attributedTitle = NSAttributedString(string: "Fetching Movie Data...")
    }
    
    @objc func handleRefreshControl() {
        fetchBoxOfficeData()
    }

}

// MARK: - DataSource
extension ViewController {
    
    private func configureDataSource() {
        let cellRegistration = UICollectionView.CellRegistration<MovieListCell, ListItem> { (cell, indexPath, movie) in
            
            cell.updateCell(with: movie)
            cell.accessories = [.disclosureIndicator()]
        }
        
        dataSource = UICollectionViewDiffableDataSource<ListSection, ListItem>(collectionView: collectionView) { (collectionView, indexPath, movie) -> UICollectionViewCell? in
            let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: movie)
            return cell
        }
        
    }
    
    private func makeSnapshot(with movies: [ListItem]) -> NSDiffableDataSourceSnapshot<ListSection, ListItem> {
        var snapshot = NSDiffableDataSourceSnapshot<ListSection, ListItem>()
        snapshot.appendSections([.main])
        snapshot.appendItems(movies, toSection: .main)
        dataSource.apply(snapshot, animatingDifferences: false)
        return snapshot
    }
    
}

// MARK: - UICollectionViewDelegate
extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}

