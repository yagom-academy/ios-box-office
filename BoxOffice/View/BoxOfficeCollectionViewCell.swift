//
//  BoxOfficeCollectionViewCell.swift
//  BoxOffice
//
//  Created by kaki, harry on 2023/04/06.
//

import UIKit

final class BoxOfficeCollectionViewCell: UICollectionViewCell, CellConfigurable {
    @IBOutlet private weak var rankLabel: UILabel!
    @IBOutlet private weak var rankInfoLabel: UILabel!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var audienceInfoLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configureBorder()
        simplifyItems()
        addSizeCategoryObserver()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        rankInfoLabel.textColor = .label
    }
    
    func configure(item: DailyBoxOffice) {
        rankLabel.text = item.rankText
        configureRankInfoLabel(item: item)
        titleLabel.text = item.movieKoreanName
        audienceInfoLabel.text = "오늘 \(item.audienceCountText.convertToDecimalText()) / 총 \(item.audienceAccumulationText.convertToDecimalText())"
    }

    @objc private func simplifyItems() {
        if traitCollection.preferredContentSizeCategory >= UIContentSizeCategory.extraExtraLarge {
            rankInfoLabel.isHidden = true
            audienceInfoLabel.isHidden = true
        } else {
            rankInfoLabel.isHidden = false
            audienceInfoLabel.isHidden = false
        }
    }
    
    private func configureBorder() {
        self.layer.borderWidth = 2
        self.layer.borderColor = UIColor.systemGray.cgColor
    }
    
    private func addSizeCategoryObserver() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(simplifyItems),
                                               name: UIContentSizeCategory.didChangeNotification,
                                               object: nil)
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
        attributedString.addAttribute(.foregroundColor, value: UIColor.label, range: (self as NSString).range(of: range))
        
        return attributedString
    }
}
