//
//  DailyMovieViewController.swift
//  BoxOffice
//
//  Created by 리지, kokkilE on 2023/03/21.
//

import UIKit

@available(iOS 14.0, *)
final class DailyMovieViewController: UIViewController {
    private var networkManager = NetworkManager()
    private var boxOfficeEndPoint: BoxOfficeEndPoint?
    
    private var refreshControl = UIRefreshControl()
    
    lazy private var collectionView = DailyMovieCollectionView(frame: view.bounds, collectionViewLayout: createLayout())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(collectionView)
        collectionView.delegate = self
        refreshData()
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        collectionView.refreshControl = refreshControl
    }
    
    @objc private func refreshData() {
        updateDateToViewTitle()
        updateDateToEndPoint()
        fetchDailyBoxOfficeData()
    }
    
    private func updateDateToViewTitle() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let currentDate = dateFormatter.string(from: Date(timeIntervalSinceNow: -86400))
        
        self.title = currentDate
    }
    
    private func updateDateToEndPoint() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd"
        let currentDate = dateFormatter.string(from: Date(timeIntervalSinceNow: -86400))
        
        boxOfficeEndPoint = BoxOfficeEndPoint.DailyBoxOffice(tagetDate: "\(currentDate)", httpMethod: .get)
    }
    
    private func fetchDailyBoxOfficeData() {
        guard let endPoint = boxOfficeEndPoint else { return }
        networkManager.request(endPoint: endPoint, returnType: DailyBoxOffice.self) { [weak self] in
            switch $0 {
            case .failure(let error):
                print(error)
            case .success(let result):
                self?.collectionView.dailyBoxOffice = result
                
                DispatchQueue.main.async {
                    self?.collectionView.setupDataSource()
                    self?.collectionView.setupSnapshot()
                    self?.refreshControl.endRefreshing()
                }
            }
        }
    }
}

@available(iOS 14.0, *)
extension DailyMovieViewController {
    private func createLayout() -> UICollectionViewLayout {
        let config = UICollectionLayoutListConfiguration(appearance: .plain)
        return UICollectionViewCompositionalLayout.list(using: config)
    }
}

@available(iOS 14.0, *)
extension DailyMovieViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}

@available(iOS 14.0, *)
extension UIConfigurationStateCustomKey {
    static let movieKey = UIConfigurationStateCustomKey("movie")
}

@available(iOS 14.0, *)
extension UICellConfigurationState {
    var movie: DailyBoxOffice.BoxOfficeResult.Movie? {
        get { return self[.movieKey] as? DailyBoxOffice.BoxOfficeResult.Movie }
        set { self[.movieKey] = newValue }
    }
}
