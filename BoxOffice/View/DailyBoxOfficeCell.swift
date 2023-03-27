//
//  DailyBoxOfficeCell.swift
//  BoxOffice
//
//  Created by Muri, Rowan on 2023/03/27.
//

import UIKit

final class DailyBoxOfficeCell: UICollectionViewListCell, Identifiable {
    var dailyBoxOfficeData: DailyBoxOfficeMovie?
    var rankLabel = UILabel()
    var rankDifferenceLabel = UILabel()
    var isConstraintNeeded = true
    var dailyBoxOfficeListContentView = UIListContentView(configuration: UIListContentConfiguration.subtitleCell())
    
    func update(with newDailyBoxOfficeData: DailyBoxOfficeMovie) {
        guard dailyBoxOfficeData != newDailyBoxOfficeData else { return }
        
        dailyBoxOfficeData = newDailyBoxOfficeData
        setLayoutConstraint()
    }
    
    override var configurationState: UICellConfigurationState {
        var state = super.configurationState
        state.dailyBoxOfficeData = self.dailyBoxOfficeData
        
        return state
    }
    
    func setLayoutConstraint() {
        guard self.isConstraintNeeded else { return }
        
        let rankStackView = {
            let stackView = UIStackView()
            stackView.axis = .vertical
            stackView.addArrangedSubview(rankLabel)
            stackView.addArrangedSubview(rankDifferenceLabel)
            stackView.alignment = .center
//            stackView.setContentHuggingPriority(.defaultHigh, for: .horizontal)
            
            return stackView
        }()
        
        [dailyBoxOfficeListContentView, rankStackView].forEach {
            self.contentView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            rankStackView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 20),
            rankStackView.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            rankStackView.widthAnchor.constraint(equalTo: self.contentView.widthAnchor, multiplier: 0.15),
            dailyBoxOfficeListContentView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 5),
            dailyBoxOfficeListContentView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -5),
            dailyBoxOfficeListContentView.leadingAnchor.constraint(equalTo: rankStackView.trailingAnchor),
            dailyBoxOfficeListContentView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor)
        ])
        
//        dailyBoxOfficeListContentView.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        
        self.isConstraintNeeded = false
    }
    
    override func updateConfiguration(using state: UICellConfigurationState) {
        guard let dailyBoxOfficeData = state.dailyBoxOfficeData else { return }
        
        setLayoutConstraint()
        
        var content = defaultContentConfiguration().updated(for: state)
        content.text = dailyBoxOfficeData.movieName
        content.textProperties.font = UIFont.preferredFont(forTextStyle: .title3)
        content.secondaryText = "오늘 \(dailyBoxOfficeData.audienceCountOfDate) /  총 \(dailyBoxOfficeData.accumulatedAudienceCount)"
        content.secondaryTextProperties.font = UIFont.preferredFont(forTextStyle: .body)
        dailyBoxOfficeListContentView.configuration = content
        
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
