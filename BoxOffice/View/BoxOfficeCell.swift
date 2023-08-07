//
//  BoxOfficeCell.swift
//  BoxOffice
//
//  Created by Dasan & Whales on 2023/08/05.
//

import UIKit

final class BoxOfficeCell: UICollectionViewListCell {
    static let Identifier = "boxOfficeCell"
    
    override func prepareForReuse() {
        super.prepareForReuse()
        rankIntensityLabel.textColor = .black
    }
    
    private let rankLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        label.textAlignment = .center
        label.adjustsFontForContentSizeCategory = true
        label.numberOfLines = 1
        
        return label
    }()
    
    private let rankIntensityLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.textAlignment = .center
        label.adjustsFontForContentSizeCategory = true
        label.numberOfLines = 1
        
        return label
    }()
    
    private let movieNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .title2)
        label.textAlignment = .left
        label.adjustsFontForContentSizeCategory = true
        label.numberOfLines = 1
        
        return label
    }()
    
    private let audienceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.textAlignment = .left
        label.adjustsFontForContentSizeCategory = true
        label.numberOfLines = 1
        
        return label
    }()
    
    private var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        
        return stackView
    }()
    
    private var rankStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        
        return stackView
    }()
    
    private var titleStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        
        return stackView
    }()
    
    private func configureLabel(with boxOfficeData: BoxOfficeData, _ rankIntensityText: NSMutableAttributedString) {
        rankLabel.text = boxOfficeData.rank
        rankIntensityLabel.text = boxOfficeData.rankIntensity
        movieNameLabel.text = boxOfficeData.movieName
        
        guard let audienceCount = CountFormatter.decimal.string(for: Int(boxOfficeData.audienceCount)),
              let audienceAccumulate = CountFormatter.decimal.string(for: Int(boxOfficeData.audienceAccumulate))
        else {
            return
        }
        
        audienceLabel.text = "오늘 \(audienceCount) / 총 \(audienceAccumulate)"
        rankIntensityLabel.attributedText = rankIntensityText
    }
        
    func configureCell(with boxOfficeData: BoxOfficeData, _ rankIntensityText: NSMutableAttributedString) {
        configureLabel(with: boxOfficeData, rankIntensityText)
        
        rankStackView.addArrangedSubview(rankLabel)
        rankStackView.addArrangedSubview(rankIntensityLabel)
        titleStackView.addArrangedSubview(movieNameLabel)
        titleStackView.addArrangedSubview(audienceLabel)
        stackView.addArrangedSubview(rankStackView)
        stackView.addArrangedSubview(titleStackView)
        
        self.addSubview(stackView)
        self.accessories = [.disclosureIndicator()]
        setUpStackViewConstraints()
    }
}

extension BoxOfficeCell {
    private func setUpStackViewConstraints() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            rankStackView.widthAnchor.constraint(
                equalTo: self.widthAnchor,
                multiplier: ConstraintsNamespace.rankStackViewFromCellWidth
            ),
            stackView.leadingAnchor.constraint(
                equalTo: self.leadingAnchor
            ),
            stackView.trailingAnchor.constraint(
                equalTo: self.trailingAnchor,
                constant: -(self.frame.width * ConstraintsNamespace.stackViewFromCellTrailing)
            ),
            stackView.topAnchor.constraint(
                equalTo: self.topAnchor,
                constant: ConstraintsNamespace.stackViewFromCellTop
            ),
            stackView.bottomAnchor.constraint(
                equalTo: self.bottomAnchor,
                constant: ConstraintsNamespace.stackViewFromCellBottom
            ),
            titleStackView.topAnchor.constraint(
                equalTo: stackView.topAnchor,
                constant: ConstraintsNamespace.titleViewFromCellTop
            ),
            titleStackView.bottomAnchor.constraint(
                equalTo: stackView.bottomAnchor,
                constant: ConstraintsNamespace.titleViewFromCellBottom
            )
        ])
    }
}
