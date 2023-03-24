//
//  BoxOfficeViewController.swift
//  BoxOffice
//
//  Created by kaki, harry on 2023/03/20.
//

import UIKit

class BoxOfficeViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerXib()
        configureCollectionView()
        collectionView.dataSource = self
    }
    
    private func registerXib() {
        let nibName = UINib(nibName: BoxOfficeCollectionViewListCell.identifier, bundle: nil)
        collectionView.register(nibName, forCellWithReuseIdentifier: BoxOfficeCollectionViewListCell.identifier)
    }
    
    private func createListLayout() -> UICollectionViewCompositionalLayout {
        let config = UICollectionLayoutListConfiguration(appearance: .plain)
        return UICollectionViewCompositionalLayout.list(using: config)
    }

    private func configureCollectionView() {
        collectionView.collectionViewLayout = createListLayout()
        view.addSubview(collectionView)
    }
}

extension BoxOfficeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BoxOfficeCollectionViewListCell.identifier, for: indexPath) as? BoxOfficeCollectionViewListCell else {
            return UICollectionViewCell()
        }
        
        cell.accessories = [
            .disclosureIndicator()
        ]
        
        return cell
    }
}
