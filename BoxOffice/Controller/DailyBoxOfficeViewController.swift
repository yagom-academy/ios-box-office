//
//  DailyBoxOfficeViewController.swift
//  BoxOffice
//
//  Created by kjs on 13/01/23.
//  last modified by Idinaloq, MARY

import UIKit

final class DailyBoxOfficeViewController: UIViewController {
    private var kobisOpenAPI: KobisOpenAPI = KobisOpenAPI()
    private var networkService: NetworkService = NetworkService()
    private var myData: BoxOffice?
    private lazy var refresh: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshCollectionView), for: .valueChanged)
        return refreshControl
    }()
    
    @objc func refreshCollectionView() {
        executeAsync()
        refresh.endRefreshing()
    }
        
    let collectionView: UICollectionView = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        executeAsync()
        configureNavigationItem()
        setupCollectionView()
        configureView()
        setUpAutolayout()
    }
       
    private func executeAsync() {
        guard let url = receiveURL() else { return }
        
        NetworkService().fetchData(url: url) { result in
            switch result {
            case .success(let data):
                self.decodeData(data)
                self.reloadCollectionView()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func receiveURL() -> URL? {
        do {
            let url = try kobisOpenAPI.receiveURL(serviceType: .dailyBoxOffice, queryItems: ["targetDt": Date().getYesterdayDate(format: "yyyyMMdd")])
            return url
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
    
    private func decodeData(_ data: Data) {
        do {
            let decodedData = try JSONDecoder().decode(BoxOffice.self, from: data)
            myData = decodedData
        } catch let error as DecodingError {
            print(error)
        } catch {
            print(error)
        }
    }
    
    private func reloadCollectionView() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    private func configureNavigationItem() {
        navigationItem.title = Date().getYesterdayDate(format: "yyyy-MM-dd")
    }
    
    private func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(DailyBoxOfficeCollectionViewCell.self,
                                forCellWithReuseIdentifier: DailyBoxOfficeCollectionViewCell.identifier)
        collectionView.refreshControl = refresh
    }
    
    private func configureView() {
        view.addSubview(collectionView)
        view.backgroundColor = .systemBackground
    }
    
    private func setUpAutolayout() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension DailyBoxOfficeViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell: DailyBoxOfficeCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: DailyBoxOfficeCollectionViewCell.identifier, for: indexPath) as? DailyBoxOfficeCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        guard let data = myData else {
            return cell
        }
        let audienceCount = data.boxOfficeResult.dailyBoxOfficeList[indexPath.item].audienceCount
        let audienceAccumulate = data.boxOfficeResult.dailyBoxOfficeList[indexPath.item].audienceAccumulate
        
        cell.titleLabel.text = data.boxOfficeResult.dailyBoxOfficeList[indexPath.item].movieName
        cell.rankLabel.text = data.boxOfficeResult.dailyBoxOfficeList[indexPath.item].rank
        cell.visitorLabel.text = "오늘 \(audienceCount) / 총 \(audienceAccumulate)"
        
        if data.boxOfficeResult.dailyBoxOfficeList[indexPath.item].rankOldAndNew == "NEW" {
            cell.rankChangeValueLabel.text = "신작"
        } else {
            cell.rankChangeValueLabel.text = data.boxOfficeResult.dailyBoxOfficeList[indexPath.item].rankChangeValue
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width
        let height = collectionView.frame.height * 0.1
        
        return CGSize(width: width, height: height)
    }
}
