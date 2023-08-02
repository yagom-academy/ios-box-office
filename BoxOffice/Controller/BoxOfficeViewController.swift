//
//  ViewController.swift
//  BoxOffice
//
//  Created by Yetti, Maxhyunm on 2023/07/24.
//

import UIKit

@available(iOS 14.0, *)
final class BoxOfficeViewController: UIViewController {
    private let collectionView: UICollectionView = {
        let configuration = UICollectionLayoutListConfiguration(appearance: .plain)
        let layout = UICollectionViewCompositionalLayout.list(using: configuration)
        let view = UICollectionView(frame: .init(), collectionViewLayout: layout)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    private func configureUI() {
        let safeArea = view.safeAreaLayoutGuide
        
        view.backgroundColor = .systemBackground
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            collectionView.leftAnchor.constraint(equalTo: safeArea.leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: safeArea.rightAnchor),
            collectionView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor)
        ])
    }
}

