//
//  DailyBoxOfficeViewController.swift
//  BoxOffice
//
//  Created by Muri, Rowan on 13/01/23.
//

import UIKit

final class DailyBoxOfficeViewController: UIViewController {
    private var collectionView: UICollectionView!
    private var dataSource: UICollectionViewDiffableDataSource<Section, DailyBoxOfficeMovie>!
    private var dailyBoxOffice: DailyBoxOffice?
    private var yesterday = Date(timeIntervalSinceNow: -(3600 * 24))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationTitle()
        loadDailyBoxOffice()
        configureCollectionView()
        configureRefreshControl()
    }
    
    private func setNavigationTitle() {
        let title = DateFormatter(dateFormat: "yyyy-MM-dd").string(from: yesterday)
        self.title = title
    }
    
    private func configureCollectionView() {
        let collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createListLayout())
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
        
        self.collectionView = collectionView
    }
    
    private func createListLayout() -> UICollectionViewCompositionalLayout {
        let configuration = UICollectionLayoutListConfiguration(appearance: .plain)
        
        return UICollectionViewCompositionalLayout.list(using: configuration)
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
                print(dailyBoxOffice)
                DispatchQueue.main.async {
                    self.configureDataSource()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func configureRefreshControl() {
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
    
    private enum Section: CaseIterable {
        case main
    }
    
    func numberFormatter(for audience: String) -> String? {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        let result = numberFormatter.string(from: Int(audience) as? NSNumber ?? 0)
        
        return result
    }
    //MARK: - cell에서가져옴
    /*
     func configureViews() {
     setLayoutConstraint()
     guard let dailyBoxOfficeData = self.dailyBoxOfficeData else { return }
     
     rankLabel.text = dailyBoxOfficeData.rank
     rankLabel.font = UIFont.preferredFont(forTextStyle: .largeTitle)
     
     switch dailyBoxOfficeData.rankOldAndNew {
     case "NEW":
     rankDifferenceLabel.text = "신작"
     rankDifferenceLabel.textColor = .systemRed
     case "OLD":
     if dailyBoxOfficeData.rankDifference.contains("-") {
     let difference = dailyBoxOfficeData.rankDifference.trimmingCharacters(in: ["-"])
     let text = "⏷" + difference
     let attributedString = NSMutableAttributedString(string: text)
     let range = NSString(string: text).range(of: "⏷")
     attributedString.addAttribute(.foregroundColor, value: UIColor.systemBlue, range: range)
     rankDifferenceLabel.attributedText = attributedString
     } else if dailyBoxOfficeData.rankDifference == "0" {
     rankDifferenceLabel.text = "-"
     } else {
     let text = "⏶" + dailyBoxOfficeData.rankDifference
     let attributedString = NSMutableAttributedString(string: text)
     let range = NSString(string: text).range(of: "⏶")
     attributedString.addAttribute(.foregroundColor, value: UIColor.systemRed, range: range)
     rankDifferenceLabel.attributedText = attributedString
     }
     default:
     rankDifferenceLabel.text = ""
     }
     
     rankDifferenceLabel.font = UIFont.preferredFont(forTextStyle: .body)
     }
     */

}
