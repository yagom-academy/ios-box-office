//
//  DailyBoxOfficeCollectionViewGridCell.swift
//  BoxOffice
//
//  Created by Idinaloq, MARY on 2023/08/16.
//

import UIKit

final class DailyBoxOfficeCollectionViewGridCell: UICollectionViewCell {
    static let identifier: String = String(describing: DailyBoxOfficeCollectionViewGridCell.self)
    
    let titleLabel: UILabel = {
        let label: UILabel = UILabel()
        label.font = .preferredFont(forTextStyle: .title2)
        label.adjustsFontForContentSizeCategory = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 3
        label.textAlignment = .center
        label.setContentHuggingPriority(.init(200), for: .vertical)
        
        return label
    }()
    
    private let visitorLabel: UILabel = {
        let label: UILabel = UILabel()
        label.font = .preferredFont(forTextStyle: .title3)
        label.adjustsFontForContentSizeCategory = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        label.setContentCompressionResistancePriority(.init(100), for: .vertical)
        
        return label
    }()
    
    private let rankLabel: UILabel = {
        let label: UILabel = UILabel()
        label.font = .preferredFont(forTextStyle: .title1)
        label.textAlignment = .center
        label.adjustsFontForContentSizeCategory = true
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let rankChangeValueLabel: UILabel = {
        let label: UILabel = UILabel()
        label.font = .preferredFont(forTextStyle: .body)
        label.textAlignment = .center
        label.adjustsFontForContentSizeCategory = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.setContentCompressionResistancePriority(.init(99), for: .vertical)
        
        return label
    }()
    
    private let dailyBoxOfficeStackView: UIStackView = {
        let stackView: UIStackView = UIStackView()
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 4
        
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
        setUpAutolayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        rankLabel.text = nil
        titleLabel.text = nil
        visitorLabel.text = nil
        rankChangeValueLabel.text = nil
        rankChangeValueLabel.textColor = nil
    }
    
    private func configureUI() {
        dailyBoxOfficeStackView.addArrangedSubview(rankLabel)
        dailyBoxOfficeStackView.addArrangedSubview(titleLabel)
        dailyBoxOfficeStackView.addArrangedSubview(rankChangeValueLabel)
        dailyBoxOfficeStackView.addArrangedSubview(visitorLabel)
        
        contentView.addSubview(dailyBoxOfficeStackView)
        self.layer.addBorder(width: 1, color: .black)
    }
    
    private func setUpAutolayout() {
        NSLayoutConstraint.activate([
            dailyBoxOfficeStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            dailyBoxOfficeStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            dailyBoxOfficeStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            dailyBoxOfficeStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }
    
    func configureCell(data: DailyBoxOffice) {
        let movieName: String = data.movieName
        let rank: String = data.rank
        let audienceCount: String = data.audienceCount
        let audienceAccumulate: String = data.audienceAccumulate
        let rankChangeValue: String = data.rankChangeValue
        let rankOldAndNew: OldAndNew? = OldAndNew(rawValue: data.rankOldAndNew)
        
        self.titleLabel.text = movieName
        self.rankLabel.text = rank
        
        do {
            let audienceCountToDecimal = try audienceCount.decimalStyleFormatter()
            let audienceAccumulateToDecimal = try audienceAccumulate.decimalStyleFormatter()
            
            self.visitorLabel.text = "오늘 \(audienceCountToDecimal) / 총 \(audienceAccumulateToDecimal)"
            
            switch (rankOldAndNew, rankChangeValue.first) {
            case (.new, _):
                self.rankChangeValueLabel.text = "신작"
                self.rankChangeValueLabel.textColor = .systemPink
            case (.old, "0"):
                self.rankChangeValueLabel.text = "-"
            case (.old, "-"):
                self.rankChangeValueLabel.attributedText = setEmojiColor(text: "▼\(rankChangeValue.dropFirst())")
            case (.old, _):
                self.rankChangeValueLabel.attributedText = setEmojiColor(text: "▲\(rankChangeValue)")
            case (_, _):
                self.rankChangeValueLabel.text = "Error"
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    private func setEmojiColor(text: String) -> NSAttributedString {
        let attributeString: NSMutableAttributedString = NSMutableAttributedString(string: text)
        
        attributeString.addAttribute(.foregroundColor, value: UIColor.systemBlue, range: (text as NSString).range(of: "▼"))
        attributeString.addAttribute(.foregroundColor, value: UIColor.systemRed, range: (text as NSString).range(of: "▲"))
        
        return attributeString
    }
    
    private enum OldAndNew: String {
        case old = "OLD"
        case new = "NEW"
    }
}
