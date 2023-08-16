//
//  BoxOfficeCollectionViewIconCell.swift
//  BoxOffice
//
//  Created by 김민성 on 2023/08/16.
//

import UIKit

class BoxOfficeCollectionViewIconCell: UICollectionViewCell {
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    private let rankLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(for: .title1, weight: .semibold)
        label.adjustsFontForContentSizeCategory = true
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    private let movieNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 3
        label.font = UIFont.preferredFont(forTextStyle: .title2)
        label.adjustsFontForContentSizeCategory = true
        return label
    }()
    
    private let rankVariationLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.adjustsFontForContentSizeCategory = true
        return label
    }()
    
    private let audienceNumberLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.minimumScaleFactor = 0.5
        label.adjustsFontSizeToFitWidth = true
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.adjustsFontForContentSizeCategory = true
        return label
    }()
    
    func configureCell(boxOfficeItem: BoxOfficeItem) {
        addSubviews()
        stackViewConstraints()
        configureCellLabels(by: boxOfficeItem)
        layer.borderColor = UIColor.black.cgColor
        layer.borderWidth = 1.0
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
        
        return rankChange.getAmountOfRankChangeString(origin: amountOfRankChange)
    }
    
}

// MARK: - Add Subviews
extension BoxOfficeCollectionViewIconCell {
    private func addSubviews() {
        addSubview(stackView)
        stackView.addArrangedSubview(rankLabel)
        stackView.addArrangedSubview(movieNameLabel)
        stackView.addArrangedSubview(rankVariationLabel)
        stackView.addArrangedSubview(audienceNumberLabel)
    }
}

extension BoxOfficeCollectionViewIconCell {
    private func stackViewConstraints() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8)
        ])
    }
}
