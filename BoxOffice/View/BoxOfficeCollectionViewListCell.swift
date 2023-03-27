//
//  BoxOfficeCollectionViewListCell.swift
//  BoxOffice
//
//  Created by kaki, harry on 2023/03/24.
//

import UIKit

final class BoxOfficeCollectionViewListCell: UICollectionViewListCell {
    @IBOutlet private weak var rankLabel: UILabel!
    @IBOutlet private weak var rankInfoLabel: UILabel!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var audienceInfoLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureLabels()
    }
    
    private func configureLabels() {
        rankLabel.font = .preferredFont(forTextStyle: .largeTitle)
        rankInfoLabel.font = .preferredFont(forTextStyle: .subheadline)
        titleLabel.font = .preferredFont(forTextStyle: .title3)
        audienceInfoLabel.font = .preferredFont(forTextStyle: .body)
    }
    
    func configureCellContent(item: DailyBoxOffice) {
        rankLabel.text = item.rankText
        
//        if item.rankOldAndNew == .new {
//            rankInfoLabel.text = "신작"
//        } else if Int(item.rankIncrementText) < 0 {
//            rankInfoLabel.text = item.rankIncrementText
//        }
        rankInfoLabel.text = item.rankIncrementText
        titleLabel.text = item.movieKoreanName
        audienceInfoLabel.text = "오늘 \(item.audienceCountText) / 총 \(item.audienceAccumulationText)"
    }
}
