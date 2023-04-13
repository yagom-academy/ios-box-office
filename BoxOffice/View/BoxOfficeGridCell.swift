//
//  BoxOfficeGridCell.swift
//  BoxOffice
//
//  Created by vetto, brody on 23/04/05.
//

import UIKit

final class BoxOfficeGridCell: UICollectionViewCell {
    private let rankLabel: UILabel = {
        let label = UILabel()
        label.adjustsFontForContentSizeCategory = true
        label.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        
        return label
    }()

     private let rankIncrementLabel: UILabel = {
        let label = UILabel()
        label.adjustsFontForContentSizeCategory = true
        label.font = UIFont.preferredFont(forTextStyle: .caption1)
         
        return label
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.adjustsFontForContentSizeCategory = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = .preferredFont(forTextStyle: .title3)
        
        return label
    }()
    
    private let audienceCountLabel: UILabel = {
        let label = UILabel()
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = CGFloat(0.4)
        label.adjustsFontForContentSizeCategory = true
        label.font = .preferredFont(forTextStyle: .body)
        label.lineBreakMode = .byWordWrapping
//        label.numberOfLines = 0
        
        return label
    }()
    
    private let movieStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        self.rankIncrementLabel.text = nil
        self.rankIncrementLabel.textColor = .black
    }
    
    func configureInformation(_ boxOfficeItem: BoxOfficeItem) {
        configureRankInformation(rank: boxOfficeItem.rank,
                                 rankIncrement: boxOfficeItem.rankIncrement,
                                 rankOldAndNew: boxOfficeItem.rankOldAndNew)
        configureMovieInformation(title: boxOfficeItem.title,
                                  audienceCount: boxOfficeItem.audienceCount,
                                  audienceAccumulationCount: boxOfficeItem.audienceAccumulationCount)
    }
    
    private func configureRankInformation(rank: String,
                                          rankIncrement: String,
                                          rankOldAndNew: String) {
        rankLabel.text = rank
        
        if rankOldAndNew == "NEW" {
            rankIncrementLabel.text = "신작"
            rankIncrementLabel.font = .preferredFont(forTextStyle: .footnote)
            rankIncrementLabel.textColor = .systemRed
        } else {
            guard let rankIncrementNumber = Int(rankIncrement) else {
                return
            }
            
            switch rankIncrementNumber {
            case ..<0:
                let attributedString = NSMutableAttributedString(string: "▼\(rankIncrementNumber * -1)")
                attributedString.addAttribute(.foregroundColor, value: UIColor.systemBlue, range: NSRange(location: 0, length: 1))
                rankIncrementLabel.attributedText = attributedString
            case 0:
                rankIncrementLabel.text = "-"
            default:
                let attributedString = NSMutableAttributedString(string: "▲\(rankIncrementNumber)")
                attributedString.addAttribute(.foregroundColor, value: UIColor.systemRed, range: NSRange(location: 0, length: 1))
                rankIncrementLabel.attributedText = attributedString
            }
        }
    }
    
    private func configureMovieInformation(title: String,
                                           audienceCount: String,
                                           audienceAccumulationCount: String) {
        titleLabel.text = title
        
        let todayAudienceCount = audienceCount.convertToDecimal()
        let accumulatedAudienceCount = audienceAccumulationCount.convertToDecimal()
    
        let audienceString = "오늘 \(todayAudienceCount) / 총: \(accumulatedAudienceCount)"
        audienceCountLabel.text = audienceString
    }
    
    private func configureUI() {
        self.contentView.layer.borderWidth = 2
        self.contentView.layer.borderColor = UIColor.systemGray.cgColor
        
        self.contentView.addSubview(self.movieStackView)
        self.movieStackView.addArrangedSubview(self.rankLabel)
        self.movieStackView.addArrangedSubview(self.titleLabel)
        self.movieStackView.addArrangedSubview(self.rankIncrementLabel)
        self.movieStackView.addArrangedSubview(self.audienceCountLabel)
        
        
        self.rankLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
        self.rankIncrementLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
        self.titleLabel.setContentHuggingPriority(.defaultLow, for: .vertical)
        self.audienceCountLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
        
        self.rankLabel.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
        self.rankIncrementLabel.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
        self.titleLabel.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
        self.audienceCountLabel.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        
        NSLayoutConstraint.activate([
            self.movieStackView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 10),
            self.movieStackView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -10),
            self.movieStackView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10),
            self.movieStackView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -10),
            
        ])
    }
}
