//
//  ViewController.swift
//  BoxOffice
//
//  Created by kjs on 13/01/23.
//

import UIKit

class ViewController: UIViewController {
    private var collectionView: UICollectionView = {
        let configuration = UICollectionLayoutListConfiguration(appearance: .plain)
        let layout = UICollectionViewCompositionalLayout.list(using: configuration)
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: layout
        )
        collectionView.register(
            MovieListCell.self,
            forCellWithReuseIdentifier: "MovieListCell"
        )
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        return collectionView
    }()
    
    private var yesterday: String {
         let yesterday = Date(timeIntervalSinceNow: -86400)
         let dateFormatter = DateFormatter()
         dateFormatter.dateFormat = "yyyyMMdd"
         
         guard let dateString = dateFormatter.string(for: yesterday) else {
             return ""
         }
         
         return dateString
     }
    
    var movieList: [DailyBoxOfficeList] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        
        autoLayout()
    }
    
    private func autoLayout() {
        view.addSubview(collectionView)
        
        let safeArea = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "MovieListCell",
            for: indexPath
        ) as? MovieListCell else {
            return UICollectionViewListCell()
        }
        
        return cell
    }
}

