//
//  BoxOfficeCollectionViewCell.swift
//  BoxOffice
//
//  Created by EtialMoon, Minsup on 2023/07/31.
//

import UIKit

final class BoxOfficeCollectionViewCell: UICollectionViewListCell {
    private let rankLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(for: .largeTitle, weight: .semibold)
        label.adjustsFontForContentSizeCategory = true
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    private let rankVariationLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.adjustsFontForContentSizeCategory = true
        return label
    }()
    
    private let movieNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = .zero
        label.font = UIFont.preferredFont(forTextStyle: .title2)
        label.adjustsFontForContentSizeCategory = true
        return label
    }()
    
    private let audienceNumberLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = .zero
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.adjustsFontForContentSizeCategory = true
        return label
    }()
    
    func configureCell(boxOfficeItem: BoxOfficeItem) {
        addSubviews()
        setUpConstraints()
        configureCellLabels(by: boxOfficeItem)
    }
    
    private func configureCellLabels(by boxOfficeItem: BoxOfficeItem) {
        rankLabel.text = boxOfficeItem.rank
        rankVariationLabel.attributedText = getRankVariationText(boxOfficeItem: boxOfficeItem)
        movieNameLabel.text = boxOfficeItem.movieName
        audienceNumberLabel.text = "오늘 \(boxOfficeItem.audienceCount.decimalFormat) / 총 \(boxOfficeItem.accumulatedAudienceCount.decimalFormat)"
    }
    
    private func getRankVariationText(boxOfficeItem: BoxOfficeItem) -> NSMutableAttributedString? {
        let amountOfRankChange = boxOfficeItem.amountOfRankChange
        let oldAndNew = boxOfficeItem.rankOldAndNew
        
        guard let rankChange = RankChangeState(amountOfRankChange, oldAndNew) else {
            return nil
        }
        
        switch rankChange {
        case .신작:
            let text = "신작"
            let attribute: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.red]
            
            return NSMutableAttributedString(string: text, attributes: attribute)
        case .변동없음:
            return NSMutableAttributedString(string: "-")
        case .상승:
            let text = "▲" + amountOfRankChange
            let string = NSMutableAttributedString(string: text)
            
            string.addAttributes([.foregroundColor: UIColor.red], range: NSRange(location: 0, length: 1))
            
            return string
        case .하락:
            let text = "▼" + amountOfRankChange.dropFirst()
            let string = NSMutableAttributedString(string: text)
            
            string.addAttributes([.foregroundColor: UIColor.blue], range: NSRange(location: 0, length: 1))
            
            return string
        }
    }
}

// MARK: - Add Subviews
extension BoxOfficeCollectionViewCell {
    private func addSubviews() {
        [rankLabel, rankVariationLabel, movieNameLabel, audienceNumberLabel].forEach {
            addSubview($0)
        }
        
        accessories = [.disclosureIndicator()]
    }
}

// MARK: - Constraints
extension BoxOfficeCollectionViewCell {
    private func setUpConstraints() {
        rankLabelConstraints()
        rankVariationLabelConstraints()
        movieNameLabelConstraints()
        audienceNumberLabelConstraints()
        separatorConstraints()
    }
    
    private func separatorConstraints() {
        separatorLayoutGuide.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
    }
    
    private func rankLabelConstraints() {
        rankLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            rankLabel.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            rankLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            rankLabel.widthAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    private func rankVariationLabelConstraints() {
        rankVariationLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            rankVariationLabel.topAnchor.constraint(equalTo: rankLabel.bottomAnchor),
            rankVariationLabel.centerXAnchor.constraint(equalTo: rankLabel.centerXAnchor),
            rankVariationLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12)
        ])
    }
    
    private func movieNameLabelConstraints() {
        movieNameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            movieNameLabel.leadingAnchor.constraint(equalTo: rankLabel.trailingAnchor, constant: 24),
            movieNameLabel.trailingAnchor.constraint(equalTo:  contentView.trailingAnchor),
            movieNameLabel.centerYAnchor.constraint(equalTo: rankLabel.centerYAnchor),
            movieNameLabel.topAnchor.constraint(greaterThanOrEqualTo: contentView.topAnchor, constant: 8)
        ])
    }
    
    private func audienceNumberLabelConstraints() {
        audienceNumberLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            audienceNumberLabel.leadingAnchor.constraint(equalTo: movieNameLabel.leadingAnchor),
            audienceNumberLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            audienceNumberLabel.topAnchor.constraint(equalTo: movieNameLabel.bottomAnchor, constant: 4),
            audienceNumberLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }
}

// MARK: - RankChangeState
extension BoxOfficeCollectionViewCell {
    enum RankChangeState {
        case 신작
        case 변동없음
        case 상승
        case 하락
        
        init?(_ amountOfRankChange: String, _ rankOldAndNew: String) {
            if amountOfRankChange == "0" && rankOldAndNew == "NEW" {
                self = .신작
            } else if amountOfRankChange == "0" && rankOldAndNew == "OLD" {
                self = .변동없음
            } else if amountOfRankChange > "0" {
                self = .상승
            } else if amountOfRankChange < "0" {
                self = .하락
            } else {
                return nil
            }
        }
    }
}
