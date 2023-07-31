//
//  BoxOfficeCollectionView.swift
//  BoxOffice
//
//  Created by EtialMoon, Minsup on 2023/07/31.
//

import SwiftUI

class BoxOfficeCollectionViewController: UICollectionViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
        configureCompositionalLayout()
        
    }
    
    private func registerCell() {
        collectionView.register(BoxOfficeCollectionViewCell.self, forCellWithReuseIdentifier: BoxOfficeCollectionViewCell.identifier)
    }
    
    private func configureCompositionalLayout() {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                 heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
      
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .fractionalHeight(0.11))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                         subitems: [item])
      
        let section = NSCollectionLayoutSection(group: group)
        
        var config = UICollectionViewCompositionalLayoutConfiguration()
        

        let layout = UICollectionViewCompositionalLayout(section: section, configuration: config)
        
        collectionView.collectionViewLayout = layout
    }
}

// MARK: - DataSource
extension BoxOfficeCollectionViewController {
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BoxOfficeCollectionViewCell.identifier, for: indexPath) as! BoxOfficeCollectionViewCell
        
        cell.configureCell()
        cell.layer.borderColor = UIColor.tertiarySystemFill.cgColor
        cell.layer.borderWidth = 0.5
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
}

// MARK: - Preview
struct BoxOfficeCollectionViewPreview: PreviewProvider {
    static var previews: some View {
        BoxOfficeCollectionViewController().toPreview()
    }
}
