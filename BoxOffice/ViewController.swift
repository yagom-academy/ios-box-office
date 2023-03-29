//
//  ViewController.swift
//  BoxOffice
//
//  Created by Seoyeon Hong on 2023/03/22.
//

import UIKit

final class ViewController: UIViewController {
    
    private var collectionView: UICollectionView!
    private var dataSource: UICollectionViewDiffableDataSource<ListSection, ListItem>!
    
    private let provider = APIProvider.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureHierarchy()
        configureDataSource()
        fetchBoxOfficeData()
        configureRefreshControl()
    }
    
    private func fetchBoxOfficeData() {
        guard let yesterday = createFormattedDate(dateFormat: "yyyyMMdd") else { return }
        provider.performRequest(api: .boxOffice(date: yesterday)) { requestResult in
            switch requestResult {
            case .success(let data):
                do {
                    let boxOfficeItem: BoxOfficeItem = try JSONConverter.shared.decodeData(data, T: BoxOfficeItem.self)
                    let dailyBoxOfficeList = boxOfficeItem.boxOfficeResult.dailyBoxOfficeList
                    var myMovieLists: [ListItem] = []
                    for dailyBoxOffice in dailyBoxOfficeList {
                        let listItem = ListItem(rank: dailyBoxOffice.rank,
                                                rankInten: dailyBoxOffice.rankInten,
                                                rankOldandNew: dailyBoxOffice.rankOldAndNew.rawValue,
                                                movieName: dailyBoxOffice.movieName,
                                                audienceCount: dailyBoxOffice.audienceCount,
                                                audienceAcc: dailyBoxOffice.audienceAcc)
                        myMovieLists.append(listItem)
                    }
                    DispatchQueue.main.async {
                        _ = self.makeSnapshot(with: myMovieLists)
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
    
    private func createFormattedDate(dateFormat: String) -> String? {
        let dateFormatter = DateFormatter()
        let today = Date()
        dateFormatter.dateFormat = dateFormat
        guard let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: today) else {
            return nil
        }
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
        guard let yesterday = createFormattedDate(dateFormat: "yyyy-MM-dd") else {
            return
        }
        navigationController?.navigationBar.topItem?.title = yesterday
        navigationController?.navigationBar.titleTextAttributes = [.font: UIFont.systemFont(ofSize: 18, weight: .bold)]
    }
    
    private func configureRefreshControl() {
        let refreshControl = UIRefreshControl()
        collectionView.refreshControl = refreshControl

        refreshControl.addTarget(self, action: #selector(handleRefreshControl), for: .valueChanged)
        refreshControl.attributedTitle = NSAttributedString(string: "Fetching Movie Data...")
    }
    
    @objc private func handleRefreshControl() {
        fetchBoxOfficeData()
    }
    
    // MARK: - DataSource
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

