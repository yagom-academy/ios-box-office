//
//  ViewController.swift
//  BoxOffice
//
//  Created by goat, songjun on 13/01/23.
//

import UIKit

final class BoxOfficeViewController: UIViewController {
    @IBOutlet weak var boxOfficeListCollectionView: UICollectionView!
    lazy var activityIndicator = UIActivityIndicatorView()
    
    private var dailyBoxOffice: DailyBoxOffice?
    private var provider = Provider()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchDailyBoxOfficeAPI()
        setUpView()
    }
    
    private func setUpView() {
        setTitle()
        setActivityIndicator()
        setBoxOfficeListCollectionView()
        configureRefreshControl()
        configureUI()
    }
    
    private func setTitle() {
        self.title = QueryItemsValue.targetDateValue.rawValue
    }
    
    private func fetchDailyBoxOfficeAPI() {
        let endpoint = EndPoint(baseURL: BaseURL.kobis,
                                path: Path.dailyBoxOffice,
                                method: HTTPMethod.get,
                                queryItems: [URLQueryItem(name: QueryItemsName.key.rawValue,
                                                          value: QueryItemsValue.keyValue.rawValue),
                                             URLQueryItem(name: QueryItemsName.targetDate.rawValue,
                                                          value: QueryItemsValue.targetDateValue.rawValue)])
        
        provider.loadBoxOfficeAPI(endpoint: endpoint,
                                  parser: Parser<DailyBoxOffice>()) { parsedData in
            self.dailyBoxOffice = parsedData
            
            DispatchQueue.main.async {
                self.boxOfficeListCollectionView.reloadData()
                self.activityIndicator.stopAnimating()
            }
        }
    }
    
    private func setActivityIndicator() {
        activityIndicator = UIActivityIndicatorView()
        activityIndicator.style = UIActivityIndicatorView.Style.large
        activityIndicator.startAnimating()
        boxOfficeListCollectionView.backgroundView = activityIndicator
    }
    
    private func setBoxOfficeListCollectionView() {
        boxOfficeListCollectionView.dataSource = self
        self.boxOfficeListCollectionView.collectionViewLayout = self.setUpCompositionalLayout()
    }
    
    private func configureRefreshControl() {
        boxOfficeListCollectionView.refreshControl = UIRefreshControl()
        boxOfficeListCollectionView.refreshControl?.addTarget(self, action:
                                                                #selector(handleRefreshControl),
                                                              for: .valueChanged)
    }
    
    @objc
    func handleRefreshControl() {
        DispatchQueue.main.async {
            self.boxOfficeListCollectionView.reloadData()
            self.boxOfficeListCollectionView.refreshControl?.endRefreshing()
        }
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
}

extension BoxOfficeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dailyBoxOffice?.boxOfficeResult.dailyBoxOfficeList.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellId = String(describing: BoxOfficeListCell.self)
        let cell = boxOfficeListCollectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! BoxOfficeListCell
        
        guard let validDailyBoxOffice = dailyBoxOffice else {
            return cell
        }
        
        cell.setUpBoxOffcieCellUI()
        cell.setUpLabel(by: validDailyBoxOffice, indexPath: indexPath)
        cell.accessories = [.disclosureIndicator() ]
    
        return cell
    }
    
    private func convertRankGapPresentation(indexPath: IndexPath) -> NSMutableAttributedString {
         guard let rankGap = dailyBoxOffice?.boxOfficeResult.dailyBoxOfficeList[indexPath.row].rankGap,
               let rankOldAndNew = dailyBoxOffice?.boxOfficeResult.dailyBoxOfficeList[indexPath.row].rankOldAndNew,
               let intRankGap = Int(rankGap) else { return NSMutableAttributedString().makeColorToText(string: "", color: .red) }
         
         if rankOldAndNew == "NEW" {
             return NSMutableAttributedString().makeColorToText(string: "신작", color: .red)
         }
         
         switch intRankGap {
         case -20 ... -1:
             return NSMutableAttributedString().makeColorToText(string: "▼", color: .blue).makeColorToText(string: rankGap.trimmingCharacters(in: ["-"]), color: .black)
         case 1...20:
             return NSMutableAttributedString().makeColorToText(string: "▲", color: .red).makeColorToText(string: rankGap, color: .black)
         case 0:
             return NSMutableAttributedString().makeColorToText(string: "-", color: .black)
         default:
             return NSMutableAttributedString().makeColorToText(string: "", color: .black)
         }
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
