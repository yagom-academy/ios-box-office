//
//  CustomCollectionViewCell.swift
//  BoxOffice
//
//  Created by 김성준 on 2023/03/27.
//

import UIKit

class CustomCollectionViewCell: UICollectionViewCell {
    private var dailyBoxOffice: DailyBoxOffice
    
    private let mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .leading
        
        return stackView
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(frame: CGRect = CGRect(x: 0, y: 0, width: 0, height: 0), item: DailyBoxOffice) {
        self.dailyBoxOffice = item
        super.init(frame: frame)
    }
    
    private func configureMainStackView() {
        mainStackView.addArrangedSubview(configureRankStackView())
        

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
            label.text = dailyBoxOffice.rank
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
    
    private func configureRankIntensityText() -> NSMutableAttributedString {
        var attributedString: NSMutableAttributedString
        var rankIntensity = dailyBoxOffice.rankIntensity
        
        if dailyBoxOffice.rankOldAndNew == "New" {
            attributedString = NSMutableAttributedString(string: "신작")
            let range = (rankIntensity as NSString).range(of: "신작")
            attributedString.addAttribute(.foregroundColor,
                                          value: UIColor.systemRed,
                                          range: range)
        }
    
        if rankIntensity.contains("-") {
            rankIntensity.removeFirst()
            attributedString = NSMutableAttributedString(string: "▼" + rankIntensity)
            let range = (rankIntensity as NSString).range(of: "▼")
            attributedString.addAttribute(.foregroundColor,
                                          value: UIColor.blue,
                                          range: range)
        } else {
            attributedString = NSMutableAttributedString(string: "▲" + rankIntensity)
            let range = (rankIntensity as NSString).range(of: "▲")
            attributedString.addAttribute(.foregroundColor,
                                          value: UIColor.red,
                                          range: range)
        }
        
        return attributedString
    }
    
}
