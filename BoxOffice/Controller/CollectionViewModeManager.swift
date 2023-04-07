//
//  CollectionViewModeManager.swift
//  BoxOffice
//
//  Created by Rowan on 2023/04/07.
//

import UIKit

enum CollectionViewMode {
    case list
    case icon
}

struct CollectionViewModeManager {
    private var collectionViewLayoutList = [CollectionViewMode: UICollectionViewCompositionalLayout]()
    private var cellRegistrationList = [CollectionViewMode: Any]()
    
    init() {
        createIconLayout()
        createListLayout()
        createIconCellRegistration()
        createListCellRegistration()
    }
    
    private mutating func createListCellRegistration() {
        let cellRegistration = UICollectionView.CellRegistration<DailyBoxOfficeListCell, DailyBoxOfficeMovie> { cell, indexPath, item in
            cell.updateData(with: item)
        }
        
        cellRegistrationList[.list] = cellRegistration
    }
    
    private mutating func createIconCellRegistration() {
        let cellRegistration = UICollectionView.CellRegistration<DailyBoxOfficeIconCell, DailyBoxOfficeMovie> { cell, indexPath, item in
            cell.updateData(with: item)
        }
        
        cellRegistrationList[.icon] = cellRegistration
    }
    
    private mutating func createListLayout() {
        let configuration = UICollectionLayoutListConfiguration(appearance: .plain)
        let layout = UICollectionViewCompositionalLayout.list(using: configuration)
        
        collectionViewLayoutList[.list] = layout
    }
    
    private mutating func createIconLayout() {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5),
                                              heightDimension: .fractionalWidth(0.5))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .fractionalHeight(0.25))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                         subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 15
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        collectionViewLayoutList[.icon] = layout
    }
}
