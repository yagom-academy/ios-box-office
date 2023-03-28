//
//  ViewController.swift
//  BoxOffice
//
//  Created by goat, songjun on 13/01/23.
//

import UIKit

final class BoxOfficeViewController: UIViewController {
    
    private var dailyBoxOffice: DailyBoxOffice?
    
    @IBOutlet weak var boxOfficeListCollectionView: UICollectionView!

    lazy var activityIndicator = UIActivityIndicatorView()
    
    private var boxOfficeAPI = BoxOfficeAPI()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTitle()
        fetchDailyBoxOfficeAPI()
        setActivityIndicator()
        boxOfficeListCollectionView.dataSource = self
        configureRefreshControl()
        self.boxOfficeListCollectionView.collectionViewLayout = self.setUpCompositionalLayout()
    }
    
    private func setTitle() {
        self.title = QueryItemsValue.targetDateValue.rawValue
    }
    
    private func configureUI() {
        let safeArea = view.safeAreaLayoutGuide
        
        boxOfficeListCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            boxOfficeListCollectionView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            boxOfficeListCollectionView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            boxOfficeListCollectionView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            boxOfficeListCollectionView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor)
        ])
    }
    
    func setActivityIndicator() {
        activityIndicator = UIActivityIndicatorView()
        activityIndicator.style = UIActivityIndicatorView.Style.large
        activityIndicator.startAnimating()
        boxOfficeListCollectionView.backgroundView = activityIndicator
    }
    
    func configureRefreshControl() {
        boxOfficeListCollectionView.refreshControl = UIRefreshControl()
        boxOfficeListCollectionView.refreshControl?.addTarget(self, action:
                                          #selector(handleRefreshControl),
                                          for: .valueChanged)
    }
    
    @objc func handleRefreshControl() {
        DispatchQueue.main.async {
            self.boxOfficeListCollectionView.reloadData()
            self.boxOfficeListCollectionView.refreshControl?.endRefreshing()
        }
    }
    
    func fetchDailyBoxOfficeAPI() {
        boxOfficeAPI.loadBoxOfficeAPI(endpoint: EndPoint(baseURL: "http://kobis.or.kr",
                        path: Path.dailyBoxOffice,
                        method: HTTPMethod.get,
                                                        queryItems: [URLQueryItem(name: QueryItemsName.key.rawValue,
                                                                                   value: QueryItemsValue.keyValue.rawValue),
                                                                      URLQueryItem(name: QueryItemsName.targetDate.rawValue,
                                                                                   value: QueryItemsValue.targetDateValue.rawValue)]), parser: Parser<DailyBoxOffice>()) { parsedData in
            self.dailyBoxOffice = parsedData
            
            DispatchQueue.main.async {
                self.boxOfficeListCollectionView.reloadData()
                self.activityIndicator.stopAnimating()
            }
        }
    }
    
    func convertRankGapPresentation(indexPath: IndexPath) -> NSMutableAttributedString {
        guard let rankGap = dailyBoxOffice?.boxOfficeResult.dailyBoxOfficeList[indexPath.row].rankGap,
              let rankOldAndNew = dailyBoxOffice?.boxOfficeResult.dailyBoxOfficeList[indexPath.row].rankOldAndNew,
              let intRankGap = Int(rankGap) else { return NSMutableAttributedString().makeRedText(string: "") }
        
        if rankOldAndNew == "NEW" {
            return NSMutableAttributedString().makeRedText(string: "신작")
        }
        
        switch intRankGap {
        case -20 ... -1:
            return NSMutableAttributedString().makeBlueText(string: "▼").makeBlackText(string: rankGap.trimmingCharacters(in: ["-"]))
        case 1...20:
            return NSMutableAttributedString().makeRedText(string: "▲").makeBlackText(string: rankGap)
        case 0:
            return NSMutableAttributedString().makeBlackText(string: "-")
        default:
            return NSMutableAttributedString().makeBlackText(string: "")
        }
    }
}

extension BoxOfficeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dailyBoxOffice?.boxOfficeResult.dailyBoxOfficeList.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellId = String(describing: BoxOfficeListCell.self)
        let cell = boxOfficeListCollectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! BoxOfficeListCell
        
        guard let audienceCount = dailyBoxOffice?.boxOfficeResult.dailyBoxOfficeList[indexPath.row].audienceCount else { return cell }
        guard let audienceAccumulation = dailyBoxOffice?.boxOfficeResult.dailyBoxOfficeList[indexPath.row].audienceAccumulation else { return cell }
        
        cell.setUpBoxOffcieCellUI()
        
        cell.accessories = [.disclosureIndicator() ]
        
        cell.rankNumberLabel.text = dailyBoxOffice?.boxOfficeResult.dailyBoxOfficeList[indexPath.row].rank
        cell.rankGapLabel.attributedText = convertRankGapPresentation(indexPath: indexPath)
        cell.movieTitleLabel.text = dailyBoxOffice?.boxOfficeResult.dailyBoxOfficeList[indexPath.row].movieName
        cell.audienceCountLabel.text = "오늘 " + audienceCount + " / 총 " + audienceAccumulation
        return cell
    }
}

extension BoxOfficeViewController {
   
    private func setUpCompositionalLayout() -> UICollectionViewLayout {
   
        let layout = UICollectionViewCompositionalLayout {
            (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            
            item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
            
            let groupHeight =  NSCollectionLayoutDimension.fractionalWidth(1/4)
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: groupHeight)
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)
            let section = NSCollectionLayoutSection(group: group)

            return section
        }
        return layout
    }
}
