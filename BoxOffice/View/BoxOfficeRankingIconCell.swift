//
//  BoxOfficeRankingIconCell.swift
//  BoxOffice
//
//  Created by Min Hyun on 2023/08/16.
//

import UIKit

class BoxOfficeRankingIconCell: UICollectionViewCell {
    static let cellIdentifier = "BoxOfficeIconCell"
    
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
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        
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
        self.layer.borderWidth = 2.0
        self.layer.borderColor = .init(gray: 0.5, alpha: 1.0)
        
        contentView.addSubview(stackView)
        stackView.addArrangedSubview(rankLabel)
        stackView.addArrangedSubview(movieNameLabel)
        stackView.addArrangedSubview(rankIntensityLabel)
        stackView.addArrangedSubview(audienceLabel)
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            stackView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.9),
            stackView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.9)
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
    
    override func prepareForReuse() {
        rankIntensityLabel.textColor = .black
    }
}
