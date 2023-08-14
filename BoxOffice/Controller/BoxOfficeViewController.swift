//
//  BoxOfficeViewController.swift
//  BoxOffice
//
//  Created by kjs on 13/01/23.
//

import UIKit

final class BoxOfficeViewController: UIViewController, UICollectionViewDelegate {
    // MARK: Propertie
    private var rankingViewType: BoxOfficeRankingViewType = .list
    private var dataManager: DataManager?
    private var boxofficeDate = {
        guard let boxofficeDate = Date.yesterday else {
            return Date()
        }
        return boxofficeDate
    }()
    
    // MARK: UI Properties
    private let loadingView = UIActivityIndicatorView()
    private let refreshController = UIRefreshControl()
    private var collectionView: UICollectionView?
    
    // MARK: DataSource Properties
    private var dataSource: UICollectionViewDiffableDataSource<BoxOfficeRankingViewType, BoxOfficeMovieInfo>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createDataManager()
        fetchBoxOfficeData()
        startLoadingView()
    }
    
    private func createDataManager() {
        dataManager = DataManager(date: boxofficeDate)
    }
    
    private func fetchBoxOfficeData() {
        dataManager?.fetchRanking(handler: handleFetchResult)
    }
    
    private func handleFetchResult(result: Result<[BoxOfficeMovieInfo], Error>) {
        switch result {
        case .success(_):
            DispatchQueue.main.async {
                self.stopLoadingView()
                self.collectionView?.refreshControl?.endRefreshing()
            }
        case .failure(let error):
            presentErrorAlert(error: error, title: "박스오피스")
        }
    }
    
    private func startLoadingView() {
        self.loadingView.startAnimating()
    }
    
    private func stopLoadingView() {
        self.loadingView.stopAnimating()
    }
    
    @objc private func refreshCollectionView() {
        self.fetchBoxOfficeData()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
    
}
