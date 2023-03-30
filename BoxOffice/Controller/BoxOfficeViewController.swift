//
//  BoxOfficeViewController.swift
//  BoxOffice
//
//  Created by Christy, Hyemory on 2023/03/20.
//

import UIKit

final class BoxOfficeViewController: UIViewController {
    private var boxOffice: BoxOffice?
    private lazy var collectionView = UICollectionView(frame: view.bounds,
                                                       collectionViewLayout: UICollectionViewFlowLayout())
    private let networkManager = NetworkManager()
    private let dateFormatter = DateFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationItem.title = Date().showYesterdayDate(formatter: dateFormatter, in: .existHyphen)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        fetchBoxOffice()
        configureCollectionView()
        configureRefreshControl()
    }
    
    private func fetchBoxOffice() {
        var api = BoxOfficeURLRequest(service: .dailyBoxOffice)
        let queryName = "targetDt"
        let queryValue = Date().showYesterdayDate(formatter: dateFormatter, in: .notHyphen)
        
        api.addQuery(name: queryName, value: queryValue)
        
        let urlRequest = api.request()
        
        networkManager.fetchData(urlRequest: urlRequest, type: BoxOffice.self) { [weak self] result in
            switch result {
            case .success(let data):
                self?.boxOffice = data
                
                DispatchQueue.main.async {
                    self?.collectionView.reloadData()
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.displayAlert(from: error)
                }
            }
        }
    }
    
    private func displayAlert(from error: Error) {
        guard let networkingError = error as? NetworkingError else { return }
        let alert = UIAlertController(title: networkingError.description, message: "모리스티에게 문의해 주세요.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "닫기", style: .cancel))
        present(alert, animated: true)
    }
}

// MARK: - BoxOfficeListCell 등록 및 DataSource 설정

extension BoxOfficeViewController {
    private func configureCollectionView() {
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
        
        collectionView.register(BoxOfficeCell.self, forCellWithReuseIdentifier: BoxOfficeCell.identifier)
    }
}

// MARK: - Refresh

extension BoxOfficeViewController {
    private func configureRefreshControl() {
        let refresh = UIRefreshControl()
        
        refresh.addTarget(self, action: #selector(handleRefreshControl), for: .valueChanged)
        collectionView.refreshControl = refresh
    }
    
    @objc private func handleRefreshControl() {
        fetchBoxOffice()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) { [weak self] in
            guard let dateFormatter = self?.dateFormatter else { return }
            
            self?.navigationItem.title = Date().showYesterdayDate(formatter: dateFormatter, in: .existHyphen)
            self?.collectionView.refreshControl?.endRefreshing()
        }
    }
}

// MARK: - Data Source

extension BoxOfficeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let boxOffice = self.boxOffice else { return 0 }
        
        return boxOffice.result.dailyBoxOfficeList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BoxOfficeCell.identifier, for: indexPath) as? BoxOfficeCell,
              let boxOfficeItem = boxOffice?.result.dailyBoxOfficeList[indexPath.item] else { return UICollectionViewCell() }
        
        cell.configureBoxOfficeStackView()
        cell.configureLabels(data: boxOfficeItem)
        cell.drawCellBorder()
        
        return cell
    }
}

// MARK: - Delegate Flow Layout

extension BoxOfficeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.bounds.width, height: view.bounds.height / 12)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
