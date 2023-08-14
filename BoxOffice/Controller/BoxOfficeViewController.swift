//
//  BoxOfficeViewController.swift
//  BoxOffice
//
//  Created by kjs on 13/01/23.
//

import UIKit

final class BoxOfficeViewController: UIViewController, UICollectionViewDelegate  {
    private var dataManager = {
        guard let yesterday = Date.yesterday else {
            return DataManager(date: Date())
        }
        
        return DataManager(date: yesterday)
    }()
    
    private let loadingView = UIActivityIndicatorView()
    private var collectionView: UICollectionView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchBoxOfficeData()
    }
    
    private func fetchBoxOfficeData() {
        dataManager.fetchRanking(handler: handleFetchResult)
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
    
}
