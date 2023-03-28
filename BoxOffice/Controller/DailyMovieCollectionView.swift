//
//  DailyMovieCollectionView.swift
//  BoxOffice
//
//  Created by 리지, kokkilE on 2023/03/28.
//

import UIKit

fileprivate enum Section: Hashable {
    case main
}

@available(iOS 14.0, *)
final class DailyMovieCollectionView: UICollectionView {
    var dailyBoxOffice: DailyBoxOffice?
    private typealias DataSource = UICollectionViewDiffableDataSource<Section, DailyBoxOffice.BoxOfficeResult.Movie>
    private var movieDataSource: DataSource?
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        self.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.register(DailyMovieListCell.self, forCellWithReuseIdentifier: DailyMovieListCell.reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupDataSource() {
        let cellRegistration = UICollectionView.CellRegistration<DailyMovieListCell, DailyBoxOffice.BoxOfficeResult.Movie> { (cell, indexPath, item) in
            cell.updateWithItem(item)
            cell.accessories = [.disclosureIndicator()]
        }
        
        movieDataSource = DataSource(collectionView: self) {
            (collectionView: UICollectionView, indexPath: IndexPath, item: DailyBoxOffice.BoxOfficeResult.Movie) -> UICollectionViewCell? in
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: item)
        }
    }
    
    func setupSnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, DailyBoxOffice.BoxOfficeResult.Movie>()
        snapshot.appendSections([.main])
        if let dailyBoxOffice = dailyBoxOffice {
            snapshot.appendItems(dailyBoxOffice.boxOfficeResult.boxOfficeList, toSection: .main)
        }
        movieDataSource?.apply(snapshot, animatingDifferences: false)
    }
   
}
