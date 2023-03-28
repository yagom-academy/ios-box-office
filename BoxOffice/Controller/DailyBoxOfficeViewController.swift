//
//  DailyBoxOfficeViewController.swift
//  BoxOffice
//
//  Created by Muri, Rowan on 13/01/23.
//

import UIKit

final class DailyBoxOfficeViewController: UIViewController {
    private var collectionView: UICollectionView!
    private var dailyBoxOffice: DailyBoxOffice?
    private var yesterday = Date(timeIntervalSinceNow: -(3600 * 24))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        LoadingIndicator.showLoading()
        setNavigationTitle()
        loadDailyBoxOffice()
        configureCollectionView()
        collectionView.dataSource = self
        collectionView.delegate = self
        configureRefreshControl()
    }
    
    private func setNavigationTitle() {
        let title = DateFormatter(dateFormat: "yyyy-MM-dd").string(from: yesterday)
        self.title = title
    }
    
    private func loadDailyBoxOffice() {
        var api = KobisAPI(service: .dailyBoxOffice)
        let targetDate = DateFormatter(dateFormat: "yyyyMMdd").string(from: yesterday)
        api.addQuery(name: "targetDt", value: targetDate)
        
        var apiProvider = APIProvider()
        apiProvider.target(api: api)
        apiProvider.startLoad(decodingType: DailyBoxOffice.self) { result in
            switch result {
            case .success(let dailyBoxOffice):
                self.dailyBoxOffice = dailyBoxOffice
                
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                    LoadingIndicator.hideLoading()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func configureCollectionView() {
        let collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UICollectionViewFlowLayout())
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
        
        collectionView.register(DailyBoxOfficeCell.self, forCellWithReuseIdentifier: "DailyBoxOfficeCell")
        
        self.collectionView = collectionView
    }
    
    private func configureRefreshControl() {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(handlerRefreshControl), for: .valueChanged)
        collectionView.refreshControl = refreshControl
    }
    
    @objc func handlerRefreshControl() {
        loadDailyBoxOffice()
        self.collectionView.reloadData()
        
        DispatchQueue.main.async {
            self.collectionView.refreshControl?.endRefreshing()
        }
    }
}

extension DailyBoxOfficeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let dailyBoxOffice = self.dailyBoxOffice else { return 0 }
        
        return dailyBoxOffice.boxOfficeResult.dailyBoxOfficeList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DailyBoxOfficeCell", for: indexPath) as? DailyBoxOfficeCell,
              let movieData = self.dailyBoxOffice?.boxOfficeResult.dailyBoxOfficeList[indexPath.item] else { return UICollectionViewCell() }
        
        cell.setData(of: movieData)
        
        return cell
    }
}

extension DailyBoxOfficeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.bounds.width, height: 100)
    }
}
