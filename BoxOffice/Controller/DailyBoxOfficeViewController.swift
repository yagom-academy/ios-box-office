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
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.center = self.view.center
        activityIndicator.color = .systemRed
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = UIActivityIndicatorView.Style.large
        activityIndicator.startAnimating()
        activityIndicator.layer.zPosition = 1
        return activityIndicator
        
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
            self.activityIndicator.stopAnimating()
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
        view.addSubview(activityIndicator)
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
        
        let movieName: String = data.boxOfficeResult.dailyBoxOfficeList[indexPath.item].movieName
        let rank: String = data.boxOfficeResult.dailyBoxOfficeList[indexPath.item].rank
        let audienceCount: String = data.boxOfficeResult.dailyBoxOfficeList[indexPath.item].audienceCount
        let audienceAccumulate: String = data.boxOfficeResult.dailyBoxOfficeList[indexPath.item].audienceAccumulate
        let rankChangeValue: String = data.boxOfficeResult.dailyBoxOfficeList[indexPath.item].rankChangeValue
        let rankOldAndNew: String = data.boxOfficeResult.dailyBoxOfficeList[indexPath.item].rankOldAndNew
        
        cell.titleLabel.text = movieName
        cell.rankLabel.text = rank
        cell.visitorLabel.text = "오늘 \(audienceCount.decimalStyleFormatter()) / 총 \(audienceAccumulate.decimalStyleFormatter())"
        
        switch (rankOldAndNew, rankChangeValue.first) {
        case ("NEW", _):
            cell.rankChangeValueLabel.text = "신작"
            cell.rankChangeValueLabel.textColor = .systemPink
        case ("OLD", "0"):
            cell.rankChangeValueLabel.text = "-"
        case ("OLD", "-"):
            cell.rankChangeValueLabel.attributedText = setEmojiColor(text: "▼\(rankChangeValue.dropFirst())")
        case ("OLD", _):
            cell.rankChangeValueLabel.attributedText = setEmojiColor(text: "▲\(rankChangeValue)")
        case (_, _):
            cell.rankChangeValueLabel.text = "Error"
        }
        
        return cell
    }
    
    private func setEmojiColor(text: String) -> NSAttributedString {
        let attributeString = NSMutableAttributedString(string: text)
        attributeString.addAttribute(.foregroundColor, value: UIColor.systemBlue, range: (text as NSString).range(of: "▼"))
        attributeString.addAttribute(.foregroundColor, value: UIColor.systemRed, range: (text as NSString).range(of: "▲"))
        return attributeString
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width
        let height = collectionView.frame.height * 0.1
        
        return CGSize(width: width, height: height)
    }
}
