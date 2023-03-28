//
//  DailyBoxOfficeCollectionView.swift
//  BoxOffice
//
//  Created by 리지, kokkilE on 2023/03/28.
//

import UIKit

fileprivate enum Section: Hashable {
    case main
}

final class DailyBoxOfficeCollectionView: UICollectionView {
    var dailyBoxOffice: DailyBoxOffice?
    private typealias DataSource = UICollectionViewDiffableDataSource<Section, DailyBoxOffice.BoxOfficeResult.Movie>
    private var movieDataSource: DataSource?
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        self.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.register(DailyBoxOfficeCollectionViewCell.self, forCellWithReuseIdentifier: DailyBoxOfficeCollectionViewCell.reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupDataSource() {
        movieDataSource = DataSource(collectionView: self) { collectionView, indexPath, itemIdentifier in
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: DailyBoxOfficeCollectionViewCell.reuseIdentifier,
                for: indexPath) as? DailyBoxOfficeCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.configure(with: itemIdentifier)
            
            return cell
        }
    }
    
    func setupSnapshot() {
        typealias Snapshot = NSDiffableDataSourceSnapshot<Section, DailyBoxOffice.BoxOfficeResult.Movie>
        var snapshot = Snapshot()
        snapshot.appendSections([.main])
        if let dailyBoxOffice = self.dailyBoxOffice {
            snapshot.appendItems(dailyBoxOffice.boxOfficeResult.boxOfficeList, toSection: .main)
        }
        movieDataSource?.apply(snapshot, animatingDifferences: true)
    }
}
