//
//  DailyBoxOfficeListCell.swift
//  BoxOffice
//
//  Created by Muri, Rowan on 2023/04/04.
//

import UIKit

final class DailyBoxOfficeListCell: UICollectionViewListCell {
    var dailyBoxOfficeData: DailyBoxOfficeMovie?
    let rankLabel = UILabel()
    let rankDifferenceLabel = UILabel()
    let dailyBoxOfficeListContentView = UIListContentView(configuration: UIListContentConfiguration.subtitleCell())

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureLayoutConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        rankDifferenceLabel.textColor = .black
    }
    
    func updateData(with newDailyBoxOfficeData: DailyBoxOfficeMovie) {
        guard dailyBoxOfficeData != newDailyBoxOfficeData else { return }
        
        dailyBoxOfficeData = newDailyBoxOfficeData
    }
    
    private func configureLayoutConstraints() {
        let rankStackView = {
            let stackView = UIStackView()
            stackView.axis = .vertical
            stackView.addArrangedSubview(rankLabel)
            stackView.addArrangedSubview(rankDifferenceLabel)
            stackView.alignment = .center
            
            return stackView
        }()
        
        [dailyBoxOfficeListContentView, rankStackView].forEach {
            self.contentView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            rankStackView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 10),
            rankStackView.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            rankStackView.widthAnchor.constraint(equalTo: self.contentView.widthAnchor, multiplier: 0.2),
            dailyBoxOfficeListContentView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 5),
            dailyBoxOfficeListContentView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -5),
            dailyBoxOfficeListContentView.leadingAnchor.constraint(equalTo: rankStackView.trailingAnchor),
            dailyBoxOfficeListContentView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor)
        ])
        
    }
    
    override func updateConfiguration(using state: UICellConfigurationState) {
        guard let dailyBoxOfficeData = self.dailyBoxOfficeData else { return }
        let textMaker = DailyBoxOfficeCellTextMaker(data: dailyBoxOfficeData)
        
        configureContentView(with: textMaker)
        configureRankLabel(with: textMaker)
        configureRankDifferenceLabel(with: textMaker)
        
        self.accessories = [.disclosureIndicator()]
    }
    
    private func configureContentView(with textMaker: DailyBoxOfficeCellTextMaker) {
        var content = defaultContentConfiguration()
        content.text = textMaker.movieTitle
        content.textProperties.font = UIFont.preferredFont(forTextStyle: .title3)
        
        content.secondaryText = textMaker.audienceCount
        content.secondaryTextProperties.font = UIFont.preferredFont(forTextStyle: .body)
        content.secondaryTextProperties.adjustsFontSizeToFitWidth = true
        content.secondaryTextProperties.minimumScaleFactor = 0.2
        content.secondaryTextProperties.numberOfLines = 1
        
        dailyBoxOfficeListContentView.configuration = content
    }

    private func configureRankLabel(with textMaker: DailyBoxOfficeCellTextMaker) {
        rankLabel.text = textMaker.rank
        rankLabel.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        rankLabel.adjustsFontForContentSizeCategory = true
        rankLabel.numberOfLines = 0
    }
    
    private func configureRankDifferenceLabel(with textMaker: DailyBoxOfficeCellTextMaker) {
        let text = textMaker.rankDifference
        switch textMaker.rankOldAndNew {
        case .new:
            rankDifferenceLabel.text = text
            rankDifferenceLabel.textColor = .systemRed
        case .old:
            if text.contains(Sign.down) {
                let attributedString = NSMutableAttributedString(string: text)
                let range = NSString(string: text).range(of: Sign.down)
                attributedString.addAttribute(.foregroundColor, value: UIColor.systemBlue, range: range)
                rankDifferenceLabel.attributedText = attributedString
            } else if text.contains(Sign.up) {
                let attributedString = NSMutableAttributedString(string: text)
                let range = NSString(string: text).range(of: Sign.up)
                attributedString.addAttribute(.foregroundColor, value: UIColor.systemRed, range: range)
                rankDifferenceLabel.attributedText = attributedString
            } else {
                rankDifferenceLabel.text = text
            }
        }
        
        rankDifferenceLabel.font = UIFont.preferredFont(forTextStyle: .body)
        rankDifferenceLabel.adjustsFontForContentSizeCategory = true
        rankDifferenceLabel.adjustsFontSizeToFitWidth = true
        rankDifferenceLabel.minimumScaleFactor = 0.2
        rankDifferenceLabel.numberOfLines = 1
    }
    
    private enum Sign {
        static let newMovie = "신작"
        static let minus = "-"
        static let zero = "0"
        static let down = "⏷"
        static let up = "⏶"
    }
}

