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
        label.numberOfLines = 0
        label.font = .preferredFont(forTextStyle: .title3)
        
        return label
    }()
    
    private let audienceCountLabel: UILabel = {
        let label = UILabel()
        label.adjustsFontForContentSizeCategory = true
        label.font = .preferredFont(forTextStyle: .body)
        
        return label
    }()
    
    private let movieStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .center
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
    
    private func configureUI() {
        self.contentView.addSubview(self.movieStackView)
        self.movieStackView.addArrangedSubview(self.rankLabel)
        self.movieStackView.addArrangedSubview(self.titleLabel)
        self.movieStackView.addArrangedSubview(self.rankIncrementLabel)
        self.movieStackView.addArrangedSubview(self.audienceCountLabel)
    }
    
    func configure(boxOfficeItem: BoxOfficeItem) {
        configureRankInformation(rank: boxOfficeItem.rank,
                                 rankIncrement: boxOfficeItem.rankIncrement,
                                 rankOldAndNew: boxOfficeItem.rankOldAndNew)
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
}
