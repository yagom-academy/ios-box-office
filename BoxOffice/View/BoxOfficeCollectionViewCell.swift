//
//  BoxOfficeCollectionViewCell.swift
//  BoxOffice
//
//  Created by EtialMoon, Minsup on 2023/07/31.
//

import UIKit

final class BoxOfficeCollectionViewCell: UICollectionViewListCell, Reusable {
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
        label.numberOfLines = 0
        label.font = UIFont.preferredFont(forTextStyle: .title2)
        label.adjustsFontForContentSizeCategory = true
        return label
    }()
    
    private let audienceNumberLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
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
        
        var amountOfRankChange = boxOfficeItem.amountOfRankChange
        
        if amountOfRankChange == "0" && boxOfficeItem.rankOldAndNew == "NEW" {
            let text = "신작"
            let attribute: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.red]
            
            return NSMutableAttributedString(string: text, attributes: attribute)
        }
        
        else if amountOfRankChange == "0" && boxOfficeItem.rankOldAndNew == "OLD" {
            return NSMutableAttributedString(string: "-")
        }
        
        else if amountOfRankChange > "0" {
            amountOfRankChange.insert("▲", at: amountOfRankChange.startIndex)
            
            let string = NSMutableAttributedString(string: amountOfRankChange)
            
            string.addAttributes([.foregroundColor: UIColor.red], range: NSRange(location: 0, length: 1))
            
            return string
        }
        
        else if amountOfRankChange < "0" {
            amountOfRankChange.removeFirst()
            amountOfRankChange.insert("▼", at: amountOfRankChange.startIndex)
            
            let string = NSMutableAttributedString(string: amountOfRankChange)
            
            string.addAttributes([.foregroundColor: UIColor.blue], range: NSRange(location: 0, length: 1))
            
            return string
        }
        
        else {
            return nil
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
