//
//  DailyBoxOfficeViewController.swift
//  BoxOffice
//
//  Created by 리지, kokkilE on 2023/03/21.
//

import UIKit

@available(iOS 14.0, *)

private enum Section: Hashable {
    case main
}

@available(iOS 14.0, *)
class DailyBoxOfficeViewController: UIViewController {
    
    fileprivate var dataSource: UICollectionViewDiffableDataSource<Section, DailyBoxOffice.BoxOfficeResult.Movie>! = nil
    var collectionView: UICollectionView!
    
    var networkManager = NetworkManager()
    var boxOfficeEndPoint: BoxOfficeEndPoint = BoxOfficeEndPoint.DailyBoxOffice(tagetDate: "20230307", httpMethod: .get)
    var dailyBoxOffice: DailyBoxOffice! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchDailyBoxOfficeData()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let currentDate = dateFormatter.string(from: Date(timeIntervalSinceNow: -86400))
        self.title = currentDate
    }
    
    private func fetchDailyBoxOfficeData() {
        networkManager.request(endPoint: boxOfficeEndPoint, returnType: DailyBoxOffice.self) { [self] in
            switch $0 {
            case .failure(let error):
                print(error)
            case .success(let result):
                self.dailyBoxOffice = result
                
                DispatchQueue.main.async { [self] in
                    configureHierarchy()
                    configureDataSource()
                }
            }
        }
    }
}

@available(iOS 14.0, *)
extension DailyBoxOfficeViewController {
    private func createLayout() -> UICollectionViewLayout {
        let config = UICollectionLayoutListConfiguration(appearance: .plain)
        return UICollectionViewCompositionalLayout.list(using: config)
    }
}

@available(iOS 14.0, *)
extension DailyBoxOfficeViewController {
    private func configureHierarchy() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createLayout())
        
        guard let collectionView = collectionView else { return }
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(collectionView)
        collectionView.delegate = self
    }
    
    /// - Tag: CellRegistration
    private func configureDataSource() {
        let cellRegistration = UICollectionView.CellRegistration<CustomListCell, DailyBoxOffice.BoxOfficeResult.Movie> { (cell, indexPath, item) in
            cell.updateWithItem(item)
            cell.accessories = [.disclosureIndicator()]
        }
        
        dataSource = UICollectionViewDiffableDataSource<Section, DailyBoxOffice.BoxOfficeResult.Movie>(collectionView: collectionView) {
            (collectionView: UICollectionView, indexPath: IndexPath, item: DailyBoxOffice.BoxOfficeResult.Movie) -> UICollectionViewCell? in
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: item)
        }
        
        // initial data
        var snapshot = NSDiffableDataSourceSnapshot<Section, DailyBoxOffice.BoxOfficeResult.Movie>()
        snapshot.appendSections([.main])
        if let dailyBoxOffice = dailyBoxOffice {
            snapshot.appendItems(dailyBoxOffice.boxOfficeResult.boxOfficeList, toSection: .main)
        }
        dataSource.apply(snapshot, animatingDifferences: false)
    }
}

@available(iOS 14.0, *)
extension DailyBoxOfficeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}

// Declare a custom key for a custom `item` property.
@available(iOS 14.0, *)
extension UIConfigurationStateCustomKey {
    static let movieKey = UIConfigurationStateCustomKey("movie")
}

// Declare an extension on the cell state struct to provide a typed property for this custom state.
@available(iOS 14.0, *)
extension UICellConfigurationState {
    var movie: DailyBoxOffice.BoxOfficeResult.Movie? {
        get { return self[.movieKey] as? DailyBoxOffice.BoxOfficeResult.Movie }
        set { self[.movieKey] = newValue }
    }
}
