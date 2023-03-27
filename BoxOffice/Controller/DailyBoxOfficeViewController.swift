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
        setNavigationTitle()
        loadDailyBoxOffice()
        configureCollectionView()
        collectionView.dataSource = self
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
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
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
        
        collectionView.register(DailyBoxOfficeCell.self, forCellWithReuseIdentifier: "DailyBoxOfficeCell")
        
        self.collectionView = collectionView
    }
    
    private func createListLayout() -> UICollectionViewFlowLayout {
        let configuration = UICollectionViewFlowLayout()
        configuration.itemSize = CGSize(width: view.bounds.width, height: 100)
        configuration.minimumLineSpacing = 0
        
        return configuration
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
        
        cell.configureSubviews()
        
        cell.movieTitleLable.text = movieData.movieName
        
        let todayAudience = convertToDecimal(target: movieData.audienceCountOfDate) ?? "0"
        let accumulatedAudience = convertToDecimal(target: movieData.accumulatedAudienceCount) ?? "0"
        cell.audienceCountLabel.text = "오늘 \(todayAudience) / 총 \(accumulatedAudience)"
        
        cell.rankLabel.text = movieData.rank
        cell.rankLabel.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        
        switch movieData.rankOldAndNew {
        case "NEW":
            cell.rankDifferenceLabel.text = "신작"
            cell.rankDifferenceLabel.textColor = .systemRed
        case "OLD":
            if movieData.rankDifference.contains("-") {
                let difference = movieData.rankDifference.trimmingCharacters(in: ["-"])
                let text = "⏷" + difference
                let attributedString = NSMutableAttributedString(string: text)
                let range = NSString(string: text).range(of: "⏷")
                attributedString.addAttribute(.foregroundColor, value: UIColor.systemBlue, range: range)
                cell.rankDifferenceLabel.attributedText = attributedString
            } else if movieData.rankDifference == "0" {
                cell.rankDifferenceLabel.text = "-"
            } else {
                let text = "⏶" + movieData.rankDifference
                let attributedString = NSMutableAttributedString(string: text)
                let range = NSString(string: text).range(of: "⏶")
                attributedString.addAttribute(.foregroundColor, value: UIColor.systemRed, range: range)
                cell.rankDifferenceLabel.attributedText = attributedString
            }
        default:
            cell.rankDifferenceLabel.text = ""
        }
        
        cell.rankDifferenceLabel.font = UIFont.preferredFont(forTextStyle: .body)
        
        return cell
    }
    
    func convertToDecimal(target: String) -> String? {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        let result = numberFormatter.string(from: Int(target) as? NSNumber ?? 0)
        
        return result
    }
}
