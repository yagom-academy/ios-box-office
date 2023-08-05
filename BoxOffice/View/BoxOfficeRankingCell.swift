//
//  BoxOfficeRankingCell.swift
//  BoxOffice
//
//  Created by Yetti, Maxhyunm on 2023/08/02.
//

import UIKit

final class BoxOfficeRankingCell: UICollectionViewListCell {
    static let cellIdentifier = "BoxOfficeCell"
    
    private let rankLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .preferredFont(forTextStyle: .largeTitle)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let rankIntensityLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .preferredFont(forTextStyle: .callout)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let movieNameLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .title3)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let audienceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpUI() {
        self.accessories = [.outlineDisclosure(options: .init(tintColor: .systemGray))]
        
        stackView.addArrangedSubview(movieNameLabel)
        stackView.addArrangedSubview(audienceLabel)
        contentView.addSubview(rankLabel)
        contentView.addSubview(rankIntensityLabel)
        contentView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            rankLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            rankLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            rankLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.3),
            
            rankIntensityLabel.widthAnchor.constraint(equalTo: rankLabel.widthAnchor),
            rankIntensityLabel.topAnchor.constraint(equalTo: rankLabel.bottomAnchor),
            rankIntensityLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            rankIntensityLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            
            stackView.leadingAnchor.constraint(equalTo: rankLabel.trailingAnchor),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            stackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            self.separatorLayoutGuide.leadingAnchor.constraint(equalTo: rankLabel.leadingAnchor)
        ])
    }
    
    func setUpLabelText(_ data: BoxOfficeEntity.BoxOfficeResult.DailyBoxOffice) {
        rankLabel.text = data.rank
        rankIntensityLabel.attributedText = setUpRankIntensity(data.rankIntensity, isNew: data.rankOldAndNew == "NEW")
        movieNameLabel.text = data.movieName
        audienceLabel.text = "오늘 \(data.audienceCount.formatToDecimalNumber()) / 총 \(data.audienceAccumulate.formatToDecimalNumber())"
    }
    
    private func setUpRankIntensity(_ rankIntensity: String, isNew: Bool) -> NSMutableAttributedString {
        var fixedIntensity = ""
        let intRankIntensity = Int(rankIntensity) ?? 0
        
        guard !isNew else {
            rankIntensityLabel.textColor = .systemRed
            return  NSMutableAttributedString(string: "신작")
        }

        if intRankIntensity == 0 {
            fixedIntensity = "-"
        } else if intRankIntensity > 0 {
            fixedIntensity = "▲\(rankIntensity)"
        } else {
            fixedIntensity = "▼\(intRankIntensity * -1)"
        }
        
        let attributedString = NSMutableAttributedString(string: fixedIntensity)
        
        attributedString.addAttribute(.foregroundColor, value: UIColor.systemRed, range: (fixedIntensity as NSString).range(of: "-"))
        attributedString.addAttribute(.foregroundColor, value: UIColor.systemRed, range: (fixedIntensity as NSString).range(of: "▲"))
        attributedString.addAttribute(.foregroundColor, value: UIColor.systemBlue, range: (fixedIntensity as NSString).range(of: "▼"))
        
        return attributedString
    }
}
