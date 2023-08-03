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
    
    private func abc() {
        do {
            let url: URL = try kobisOpenAPI.receiveURL(serviceType: .dailyBoxOffice, queryItems: ["targetDt": Date().getYesterdayDate(format: "yyyyMMdd")])
            networking(url: url)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    private func networking(url: URL) {
        NetworkService().fetchData(url: url) { result in
            switch result {
            case .success(let data):
                do {
                    let decodedData = try JSONDecoder().decode(BoxOffice.self, from: data)
                    self.myData = decodedData
                    DispatchQueue.main.async {
                        self.collectionView.reloadData()
                    }
                } catch let error as DecodingError {
                    print(error)
                } catch {
                    print(error)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    let collectionView: UICollectionView = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        abc()
        
        configureNavigationItem()
        setupCollectionView()
        configureView()
        setUpAutolayout()
    }
    
    private func configureNavigationItem() {
        navigationItem.title = Date().getYesterdayDate(format: "yyyy-MM-dd")
    }
    
    private func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(DailyBoxOfficeCollectionViewCell.self,
                                forCellWithReuseIdentifier: DailyBoxOfficeCollectionViewCell.identifier)
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
