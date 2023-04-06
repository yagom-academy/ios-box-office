//
//  DailyBoxOfficeIconCell.swift
//  BoxOffice
//
//  Created by Muri, Rowan on 2023/04/06.
//

import UIKit

final class DailyBoxOfficeIconCell: UICollectionViewCell {
    var dailyBoxOfficeData: DailyBoxOfficeMovie?
    let rankLabel = UILabel()
    let rankDifferenceLabel = UILabel()
    let movieTitleLabel = UILabel()
    let audienceLabel = UILabel()
    
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
        let dailyBoxOfficeStackView = {
            let stackView = UIStackView()
            stackView.axis = .vertical
            stackView.alignment = .center
            stackView.addArrangedSubview(rankLabel)
            stackView.addArrangedSubview(movieTitleLabel)
            stackView.addArrangedSubview(rankDifferenceLabel)
            stackView.addArrangedSubview(audienceLabel)
            
            return stackView
        }()
        
        self.contentView.addSubview(dailyBoxOfficeStackView)
        
        NSLayoutConstraint.activate([
            dailyBoxOfficeStackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            dailyBoxOfficeStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            dailyBoxOfficeStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            dailyBoxOfficeStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    override func updateConfiguration(using state: UICellConfigurationState) {
        guard let dailyBoxOfficeData = self.dailyBoxOfficeData else { return }
        let textMaker = TextMaker(data: dailyBoxOfficeData)
        
        configureRankLabel(with: textMaker)
        configureMovieTitleLabel(with: textMaker)
        configureRankDifferenceLabel(with: textMaker)
        configureAudienceLabel(with: textMaker)
    }
    
    private func configureRankLabel(with textMaker: TextMaker) {
        rankLabel.text = textMaker.rank
        rankLabel.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        rankLabel.adjustsFontForContentSizeCategory = true
    }
    
    private func configureMovieTitleLabel(with textMaker: TextMaker) {
        movieTitleLabel.text = textMaker.movieTitle
        movieTitleLabel.font = UIFont.preferredFont(forTextStyle: .title3)
        movieTitleLabel.adjustsFontForContentSizeCategory = true
    }
    
    private func configureRankDifferenceLabel(with textMaker: TextMaker) {
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
    
    private func configureAudienceLabel(with textMaker: TextMaker) {
        audienceLabel.text = textMaker.audienceCount
        audienceLabel.font = UIFont.preferredFont(forTextStyle: .body)
        audienceLabel.adjustsFontForContentSizeCategory = true
        audienceLabel.adjustsFontSizeToFitWidth = true
        audienceLabel.minimumScaleFactor = 0.2
        audienceLabel.numberOfLines = 1
    }
    
    private enum Sign {
        static let newMovie = "신작"
        static let minus = "-"
        static let zero = "0"
        static let down = "⏷"
        static let up = "⏶"
    }
}
