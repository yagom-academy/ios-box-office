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
    
    var oppositeString: String {
        switch self {
        case .icon:
            return "리스트"
        case .list:
            return "아이콘"
        }
    }
}

struct CollectionViewModeManager {
    private var collectionViewLayoutList = [CollectionViewMode: UICollectionViewCompositionalLayout]()
    
    init() {
        createIconLayout()
        createListLayout()
    }
    
    func layout(mode: CollectionViewMode) -> UICollectionViewCompositionalLayout {
        guard let layout = collectionViewLayoutList[mode] else {
            let configuration = UICollectionLayoutListConfiguration(appearance: .plain)
            
            return UICollectionViewCompositionalLayout.list(using: configuration)
        }
        
        switch mode {
        case .icon:
            return layout
        case .list:
            return layout
        }
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
        item.contentInsets = NSDirectionalEdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .fractionalHeight(0.25))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                         subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 20
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 5, bottom: 30, trailing: 5)
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        collectionViewLayoutList[.icon] = layout
    }
}
