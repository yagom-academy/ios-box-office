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
        self.accessories = [
            .disclosureIndicator()
        ]
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        rankInfoLabel.textColor = .black
    }
    
    func configure(item: DailyBoxOffice) {
        rankLabel.text = item.rankText
        configureRankInfoLabel(item: item)
        titleLabel.text = item.movieKoreanName
        audienceInfoLabel.text = "오늘 \(item.audienceCountText.convertToDecimalText()) / 총 \(item.audienceAccumulationText.convertToDecimalText())"
    }
    
    private func configureLabels() {
        rankLabel.font = .preferredFont(forTextStyle: .largeTitle)
        rankInfoLabel.font = .preferredFont(forTextStyle: .subheadline)
        titleLabel.font = .preferredFont(forTextStyle: .title3)
        audienceInfoLabel.font = .preferredFont(forTextStyle: .body)
    }
    
    private func configureRankInfoLabel(item: DailyBoxOffice) {
        switch item.rankOldAndNew {
        case .new:
            rankInfoLabel.text = "신작"
            rankInfoLabel.textColor = .systemRed
        case .old:
            guard let increment = Int(item.rankIncrementText) else { return }
            
            if increment > 0 {
                rankInfoLabel.textColor = .systemRed
                rankInfoLabel.attributedText = "▲\(increment)".attributedString
            } else if increment < 0 {
                rankInfoLabel.textColor = .systemBlue
                rankInfoLabel.attributedText = "▼\(increment * -1)".attributedString
            } else {
                rankInfoLabel.text = "-"
            }
        }
    }
}

fileprivate extension String {
    var attributedString: NSMutableAttributedString {
        let attributedString = NSMutableAttributedString(string: self)
        let index = self.index(after: self.startIndex)
        
        let range = String(self[index...])
        attributedString.addAttribute(.foregroundColor, value: UIColor.black, range: (self as NSString).range(of: range))
        
        return attributedString
    }
}
