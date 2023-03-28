//
//  DailyBoxOfficeCell.swift
//  BoxOffice
//
//  Created by Muri, Rowan on 2023/03/27.
//

import UIKit

final class DailyBoxOfficeCell: UICollectionViewCell {
    static let identifier = "DailyBoxOfficeCell"
    
    private var isConstraintNeeded = true
    private let rankLabel = UILabel()
    private let rankDifferenceLabel = UILabel()
    private let movieTitleLable = UILabel()
    private let audienceCountLabel = UILabel()
    private let rankStackView = {
      let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    private let movieStackView = {
       let stackView = UIStackView()
        
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    private let accessoryView = {
        let imageView = UIImageView()
        let configuration = UIImage.SymbolConfiguration(weight: .bold)
        imageView.image = UIImage(systemName: "chevron.right", withConfiguration: configuration)
        imageView.tintColor = UIColor.systemGray4
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        rankDifferenceLabel.textColor = .black
    }
    
    func setBorder() {
        layer.addBorder(color: .systemGray5, width: 1)
    }
    
    func configureSubviews() {
        setViewHierarchy()
        setSubviewConstraints()
    }
    
    private func setViewHierarchy() {
        rankStackView.addArrangedSubview(rankLabel)
        rankStackView.addArrangedSubview(rankDifferenceLabel)
        
        movieStackView.addArrangedSubview(movieTitleLable)
        movieStackView.addArrangedSubview(audienceCountLabel)
        
        contentView.addSubview(rankStackView)
        contentView.addSubview(movieStackView)
        contentView.addSubview(accessoryView)
    }
    
    private func setSubviewConstraints() {
        if isConstraintNeeded {
            NSLayoutConstraint.activate([
                rankStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
                rankStackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
                rankStackView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.15),
                
                movieStackView.leadingAnchor.constraint(equalTo: rankStackView.trailingAnchor, constant: 10),
                movieStackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
                
                accessoryView.leadingAnchor.constraint(equalTo: movieStackView.trailingAnchor),
                accessoryView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
                accessoryView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
                accessoryView.widthAnchor.constraint(equalToConstant: 10),
                accessoryView.heightAnchor.constraint(equalToConstant: 15)
            ])
        }
        
        isConstraintNeeded = false
    }
    
    func fillLabels(with data: DailyBoxOfficeMovie) {
        fillRankLabel(with: data)
        fillRankDifferenceLabel(with: data)
        fillMovieTitleLabel(with: data)
        fillAudienceCountLabel(with: data)
    }
    
    private func fillMovieTitleLabel(with data: DailyBoxOfficeMovie) {
        movieTitleLable.text = data.movieName
        movieTitleLable.font = UIFont.preferredFont(forTextStyle: .title3)
        movieTitleLable.numberOfLines = 0
    }
    
    private func fillAudienceCountLabel(with data: DailyBoxOfficeMovie) {
        let todayAudience = NumberFormat.decimal(target: data.audienceCountOfDate) ?? "0"
        let accumulatedAudience = NumberFormat.decimal(target: data.accumulatedAudienceCount) ?? "0"
        audienceCountLabel.text = "오늘 \(todayAudience) / 총 \(accumulatedAudience)"
        audienceCountLabel.font = UIFont.preferredFont(forTextStyle: .body)
    }
    
    private func fillRankLabel(with data: DailyBoxOfficeMovie) {
        rankLabel.text = data.rank
        rankLabel.font = UIFont.preferredFont(forTextStyle: .largeTitle)
    }
    
    private func fillRankDifferenceLabel(with data: DailyBoxOfficeMovie) {
        switch data.rankOldAndNew {
        case "NEW":
            rankDifferenceLabel.text = "신작"
            rankDifferenceLabel.textColor = .systemRed
        case "OLD":
            if data.rankDifference.contains("-") {
                let difference = data.rankDifference.trimmingCharacters(in: ["-"])
                let text = "⏷" + difference
                let attributedString = NSMutableAttributedString(string: text)
                let range = NSString(string: text).range(of: "⏷")
                attributedString.addAttribute(.foregroundColor, value: UIColor.systemBlue, range: range)
                rankDifferenceLabel.attributedText = attributedString
            } else if data.rankDifference == "0" {
                rankDifferenceLabel.text = "-"
            } else {
                let text = "⏶" + data.rankDifference
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
