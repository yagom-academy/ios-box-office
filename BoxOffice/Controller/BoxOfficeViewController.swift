//
//  BoxOfficeViewController.swift
//  BoxOffice
//
//  Created by kyungmin, Erick on 2023/07/24.
//

import UIKit

class BoxOfficeViewController: UIViewController {
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()
        configureUI()
        setupConstraint()
        setupNavigationBar()
    }
    
    func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(BoxOfficeCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
    }
}

extension BoxOfficeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? BoxOfficeCollectionViewCell else {
            return BoxOfficeCollectionViewCell()
        }
        
        return cell
    }
}

extension BoxOfficeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.width / 5)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

// MARK: setup UI
extension BoxOfficeViewController {
    func configureUI() {
        view.backgroundColor = .systemBackground
        view.addSubview(collectionView)
    }
    
    func setupConstraint() {
        let safaArea = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: safaArea.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: safaArea.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: safaArea.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: safaArea.bottomAnchor)
        ])
    }
    
    func setupNavigationBar() {
        
    }
}
