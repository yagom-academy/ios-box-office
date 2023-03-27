//
//  DailyBoxOfficeCell.swift
//  BoxOffice
//
//  Created by Muri, Rowan on 2023/03/27.
//

import UIKit

@available(iOS 14.0, *)
class DailyBoxOfficeCell: UICollectionViewListCell {
    private var boxOfficeData: DailyBoxOffice?
    var rankLabel: UILabel!
    var rankDifferenceLabel: UILabel!
    
    private func defaultBoxOfficeConfiguration() -> UIListContentConfiguration {
        return .subtitleCell()
    }
    
    private lazy var dailyBoxOfficeContentView = UIListContentView(configuration: defaultBoxOfficeConfiguration())
    
    func setLayoutConstraint() {
        let rankStackView = {
            let stackView = UIStackView()
            stackView.axis = .vertical
            stackView.addArrangedSubview(rankLabel)
            stackView.addArrangedSubview(rankDifferenceLabel)
            
            return stackView
        }()
        
        [dailyBoxOfficeContentView, rankStackView].forEach {
            self.contentView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            rankStackView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            rankStackView.trailingAnchor.constraint(equalTo: dailyBoxOfficeContentView.leadingAnchor),
            rankStackView.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            dailyBoxOfficeContentView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            dailyBoxOfficeContentView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
            dailyBoxOfficeContentView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor)
        ])
    }
}
