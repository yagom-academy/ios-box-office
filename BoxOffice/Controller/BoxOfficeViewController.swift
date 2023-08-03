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
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.center = view.center
        activityIndicator.startAnimating()
        
        return activityIndicator
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigation()
        setupCollectionView()
        setupRefreshControl()
        loadBoxOfficeData()
        
        configureUI()
        setupConstraint()
    }
    
    private func setupNavigation() {
        self.navigationItem.title = DateFormatter().bringDateString(before: 1, with: DateFormatter.FormatCase.hyphen)
    }
    
    private func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(BoxOfficeCollectionViewCell.self, forCellWithReuseIdentifier: BoxOfficeCollectionViewCell.identifier)
    }
    
    private func setupRefreshControl() {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(loadBoxOfficeData), for: .valueChanged)
        
        collectionView.refreshControl = refreshControl
    }
    
    @objc private func loadBoxOfficeData() {
        boxOfficeManager.fetchBoxOffice { [weak self] error in
            if let error {
                print(error.localizedDescription)
                
                let alert = UIAlertController.makedBasicAlert(NameSpace.fail, NameSpace.loadDataFail, actionTitle: NameSpace.check, actionType: .default)
                
                DispatchQueue.main.async {
                    self?.collectionView.refreshControl?.endRefreshing()
                    self?.activityIndicator.stopAnimating()
                    self?.present(alert, animated: true)
                }
                
                return
            }
            
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
                self?.collectionView.refreshControl?.endRefreshing()
                self?.activityIndicator.stopAnimating()
            }
        }
    }
}

// MARK: UICollectionViewDataSource
extension BoxOfficeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return boxOfficeManager.dailyBoxOfficeDatas.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BoxOfficeCollectionViewCell.identifier, for: indexPath) as? BoxOfficeCollectionViewCell else {
            return BoxOfficeCollectionViewCell()
        }
        
        let dailyBoxOfficeData = boxOfficeManager.dailyBoxOfficeDatas[indexPath.item]
        cell.setupBoxOfficeData(dailyBoxOfficeData)
        
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
        view.addSubview(activityIndicator)
    }
    
    private func setupConstraint() {
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

// MARK: Name Space
extension BoxOfficeViewController {
    enum NameSpace {
        static let fail = "실패"
        static let loadDataFail = "데이터 로드에 실패했습니다."
        static let check = "확인"
    }
}
