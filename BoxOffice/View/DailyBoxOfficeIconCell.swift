//
//  DailyBoxOfficeIconCell.swift
//  BoxOffice
//
//  Created by Muri, Rowan on 2023/04/06.
//

import UIKit

final class DailyBoxOfficeIconCell: UICollectionViewCell {
    static let identifier = "iconCell"
    
    private var movieData: DailyBoxOfficeMovie?
    private let rankLabel = UILabel()
    private let rankDifferenceLabel = UILabel()
    private let movieTitleLabel = UILabel()
    private let audienceLabel = UILabel()
    
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

    override func updateConfiguration(using state: UICellConfigurationState) {
        guard let dailyBoxOfficeData = self.movieData else { return }
        let textMaker = DailyBoxOfficeCellTextMaker(data: dailyBoxOfficeData)
        
        configureRankLabel(with: textMaker)
        configureMovieTitleLabel(with: textMaker)
        configureRankDifferenceLabel(with: textMaker)
        configureAudienceLabel(with: textMaker)
        configureBackgroud()
    }
}

extension DailyBoxOfficeIconCell: MovieDataUpdatable {
    func updateMovieDataIfNeeded(newData: DailyBoxOfficeMovie) {
        guard movieData != newData else { return }
        
        updateData(with: newData)
    }
    
    private func updateData(with newMovieData: DailyBoxOfficeMovie) {
        movieData = newMovieData
    }
}

extension DailyBoxOfficeIconCell {
    private func configureLayoutConstraints() {
        let dailyBoxOfficeStackView = {
            let stackView = UIStackView()
            stackView.axis = .vertical
            stackView.alignment = .center
            stackView.distribution = .equalCentering
            stackView.addArrangedSubview(rankLabel)
            stackView.addArrangedSubview(movieTitleLabel)
            stackView.addArrangedSubview(rankDifferenceLabel)
            stackView.addArrangedSubview(audienceLabel)
            stackView.translatesAutoresizingMaskIntoConstraints = false
            
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
    
    private func configureRankLabel(with textMaker: DailyBoxOfficeCellTextMaker) {
        rankLabel.text = textMaker.rank
        rankLabel.font = UIFont.preferredFont(forTextStyle: .largeTitle)
    }
    
    private func configureMovieTitleLabel(with textMaker: DailyBoxOfficeCellTextMaker) {
        movieTitleLabel.text = textMaker.movieTitle
        movieTitleLabel.textAlignment = .center
        movieTitleLabel.font = UIFont.preferredFont(forTextStyle: .title3)
        movieTitleLabel.adjustsFontForContentSizeCategory = true
        movieTitleLabel.numberOfLines = 0
        movieTitleLabel.setContentCompressionResistancePriority(.required, for: .vertical)
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
        rankDifferenceLabel.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
    }
    
    private func configureAudienceLabel(with textMaker: DailyBoxOfficeCellTextMaker) {
        audienceLabel.text = textMaker.audienceCount
        audienceLabel.font = UIFont.preferredFont(forTextStyle: .body)
        audienceLabel.adjustsFontForContentSizeCategory = true
        audienceLabel.adjustsFontSizeToFitWidth = true
        audienceLabel.minimumScaleFactor = 0.3
        audienceLabel.numberOfLines = 1
        audienceLabel.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
    }
    
    private func configureBackgroud() {
        var backgroundConfiguration = UIBackgroundConfiguration.listPlainCell()
        backgroundConfiguration.strokeWidth = 3.0
        backgroundConfiguration.strokeOutset = 10
        backgroundConfiguration.strokeColor = .systemGray2
        
        self.backgroundConfiguration = backgroundConfiguration
    }
    
    private enum Sign {
        static let newMovie = "신작"
        static let minus = "-"
        static let zero = "0"
        static let down = "⏷"
        static let up = "⏶"
    }
}
