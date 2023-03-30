//
//  CustomCollectionViewCell.swift
//  BoxOffice
//
//  Created by Rhode, Rilla on 2023/03/27.
//

import UIKit

final class CustomCollectionViewCell: UICollectionViewListCell {
    static let identifier = "CustomCollectionViewCell"
    private var dailyBoxOffice: DailyBoxOffice?
    
    private let mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .center
        
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureCellStyle()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        mainStackView.arrangedSubviews.forEach { view in
            view.removeFromSuperview()
        }
    }
    
    func configureCellStyle() {
        self.accessories = [.disclosureIndicator()]
        self.layer.addBorder([.bottom], color: .systemGray3, width: 0.8)
    }
    
    func configureDailyBoxOffice(dailyBoxOffice: DailyBoxOffice?) {
        self.dailyBoxOffice = dailyBoxOffice
        configureMainStackView()
    }
    
    private func configureMainStackView() {
        let rankStackView = configureRankStackView()
        let audienceStackView = configureAudienceStackView()
        
        self.addSubview(mainStackView)
        
        mainStackView.addArrangedSubview(rankStackView)
        mainStackView.addArrangedSubview(audienceStackView)
        
        mainStackView.setAutoLayout(equalTo: self.safeAreaLayoutGuide)
        
        NSLayoutConstraint.activate([
            rankStackView.widthAnchor.constraint(equalTo: mainStackView.heightAnchor),
        ])
    }
    
    private func configureRankStackView() -> UIStackView {
        let rankStackView: UIStackView = {
            let stackView = UIStackView()
            stackView.axis = .vertical
            stackView.distribution = .fill
            stackView.alignment = .center
            
            return stackView
        }()
        
        let rankLabel: UILabel = {
            let label = UILabel()
            label.text = dailyBoxOffice?.rank
            label.font = .preferredFont(forTextStyle: .largeTitle)
            
            return label
        }()
        
        let rankIntensityLabel: UILabel = {
            let label = UILabel()
            label.attributedText = configureRankIntensityText()
            label.font = .preferredFont(forTextStyle: .body)
            
            return label
        }()
        
        rankStackView.addArrangedSubview(rankLabel)
        rankStackView.addArrangedSubview(rankIntensityLabel)
        
        return rankStackView
    }
    
    private func configureRankIntensityText() -> NSMutableAttributedString? {
        var attributedString: NSMutableAttributedString
        guard var rankIntensity = dailyBoxOffice?.rankIntensity else { return nil }
        
        if dailyBoxOffice?.rankOldAndNew == "NEW" {
            attributedString = NSMutableAttributedString(string: "신작")
            let range = ("신작" as NSString).range(of: "신작")
            attributedString.addAttribute(.foregroundColor,
                                          value: UIColor.systemRed,
                                          range: range)
            return attributedString
        }
        
        if rankIntensity == "0" {
            return NSMutableAttributedString(string: "-")
        }
        
        if rankIntensity.contains("-") {
            rankIntensity.removeFirst()
            let rankIntensityText = "▼" + rankIntensity
            attributedString = NSMutableAttributedString(string: rankIntensityText)
            let range = (rankIntensityText as NSString).range(of: "▼")
            attributedString.addAttribute(.foregroundColor,
                                          value: UIColor.blue,
                                          range: range)
        } else {
            let rankIntensityText = "▲" + rankIntensity
            attributedString = NSMutableAttributedString(string: rankIntensityText)
            let range = (rankIntensityText as NSString).range(of: "▲")
            attributedString.addAttribute(.foregroundColor,
                                          value: UIColor.red,
                                          range: range)
        }
        
        return attributedString
    }
    
    private func configureAudienceStackView() -> UIStackView {
        let audienceStackView: UIStackView = {
            let stackView = UIStackView()
            stackView.axis = .vertical
            stackView.distribution = .fillProportionally
            stackView.alignment = .leading
            stackView.spacing = 8
            
            return stackView
        }()
        
        let movieNameLabel: UILabel = {
            let label = UILabel()
            label.text = dailyBoxOffice?.movieName
            label.textAlignment = .left
            label.font = .preferredFont(forTextStyle: .body)
            
            return label
        }()
        
        let audienceLabel: UILabel = {
            let label = UILabel()
             if let count = dailyBoxOffice?.audienceCount.formatNumberString(),
                let accumulation = dailyBoxOffice?.audienceAccumulation.formatNumberString() {
                 label.text = "오늘 \(count) / 총 \(accumulation)"
                 label.textAlignment = .left
                 label.font = .preferredFont(forTextStyle: .caption1)
                 
                 return label
             }
            
            return label
        }()
        
        audienceStackView.addArrangedSubview(movieNameLabel)
        audienceStackView.addArrangedSubview(audienceLabel)
        
        return audienceStackView
    }
}
