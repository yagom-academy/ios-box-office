//
//  DailyBoxOfficeViewController.swift
//  BoxOffice
//
//  Created by kjs on 13/01/23.
//  last modified by Idinaloq, MARY

import UIKit

final class DailyBoxOfficeViewController: UIViewController {
    let collectionView: UICollectionView = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
//        layout.minimumLineSpacing = 15
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        configureNavigationItem()
    }
    
    private func configureNavigationItem() {
        navigationItem.title = "2020-01-01"
    }
    
}

