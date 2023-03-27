//
//  DailyBoxOfficeCell.swift
//  BoxOffice
//
//  Created by Muri, Rowan on 2023/03/27.
//

import UIKit

final class DailyBoxOfficeCell: UICollectionViewCell {
    var dailyBoxOfficeData: DailyBoxOfficeMovie?
    var isConstraintNeeded = true
    var rankLabel = UILabel()
    var rankDifferenceLabel = UILabel()
    var movieTitleLable = UILabel()
    var audienceCountLabel = UILabel()
    
    func setLayoutConstraint() {
        
    }
    
    func numberFormatter(for audience: String) -> String? {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        let result = numberFormatter.string(from: Int(audience) as? NSNumber ?? 0)
        
        return result
    }
    
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
}

private extension UIConfigurationStateCustomKey {
    static let dailyBoxOffice = UIConfigurationStateCustomKey("dailyBoxOffice")
}

extension UIConfigurationState {
    var dailyBoxOfficeData: DailyBoxOfficeMovie? {
        get { return self[.dailyBoxOffice] as? DailyBoxOfficeMovie }
        set { self[.dailyBoxOffice] = newValue }
    }
}
