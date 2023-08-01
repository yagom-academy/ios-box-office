//
//  BoxOfficeViewController.swift
//  BoxOffice
//
//  Created by kyungmin, Erick on 2023/07/24.
//

import UIKit

final class BoxOfficeViewController: UIViewController {
    private let boxOfficeManager = BoxOfficeManager()
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()
        setupRefreshControl()
        configureUI()
        setupConstraint()
        setupNavigationBar()
        loadBoxOfficeData()
    }
    
    private func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(BoxOfficeCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
    }
    
    private func setupRefreshControl() {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(reloadBoxOfficeData(refresh:)), for: .valueChanged)
        
        collectionView.refreshControl = refreshControl
    }
    
    private func loadBoxOfficeData() {
        boxOfficeManager.fetchBoxOffice { error in
            if let error {
                print(error.localizedDescription)
                return
            }
            
            DispatchQueue.main.async {
                self.collectionView.reloadData()
    @objc private func reloadBoxOfficeData(refresh: UIRefreshControl) {
        boxOfficeManager.fetchBoxOffice { error in
            if let error {
                print(error.localizedDescription)
                return
            }
            
            DispatchQueue.main.async {
                self.collectionView.reloadData()
                refresh.endRefreshing()
            }
        }
    }
}

// MARK: UICollectionViewDataSource
extension BoxOfficeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return boxOfficeManager.boxOfficeList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? BoxOfficeCollectionViewCell else {
            return BoxOfficeCollectionViewCell()
        }
        
        let boxOfficeList = boxOfficeManager.boxOfficeList
        
        if !boxOfficeList.isEmpty {
            let dailyBoxOfficeList = boxOfficeList[indexPath.item]
            cell.setupBoxOfficeData(dailyBoxOfficeList)
        }
        
        return cell
    }
}

// MARK: UICollectionViewDelegateFlowLayout
extension BoxOfficeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.width / 5)
    }
}

// MARK: setup UI
extension BoxOfficeViewController {
    private func configureUI() {
        view.backgroundColor = .systemBackground
        view.addSubview(collectionView)
    }
    
    private func setupConstraint() {
        let safaArea = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: safaArea.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: safaArea.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: safaArea.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: safaArea.bottomAnchor)
        ])
    }
    
    private func setupNavigationBar() {
        
    }
}
