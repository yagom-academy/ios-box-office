//
//  BoxOfficeListCell.swift
//  BoxOffice
//
//  Created by Christy, Hyemory on 2023/03/28.
//

import UIKit

private extension UIConfigurationStateCustomKey {
    static let boxOffice = UIConfigurationStateCustomKey("boxOffice")
}

extension UIConfigurationState {
    var dailyBoxOfficeItem: DailyBoxOfficeItem? {
        get { return self[.boxOffice] as? DailyBoxOfficeItem }
        set { self[.boxOffice] = newValue }
    }
}

final class BoxOfficeListCell: UICollectionViewListCell {
    private var dailyBoxOfficeItem: DailyBoxOfficeItem?
    private let rankStackView = RankStackView()
    
    private func defaultBoxOfficeConfiguration() -> UIListContentConfiguration {
        return .subtitleCell()
    }
    
    private var boxOfficeTypeConstraints: (leading: NSLayoutConstraint, trailing: NSLayoutConstraint)?
    
    private lazy var boxOfficeListContentView = UIListContentView(configuration: defaultBoxOfficeConfiguration())
    
    func update(with newItem: DailyBoxOfficeItem) {
        guard dailyBoxOfficeItem != newItem else { return }
        
        dailyBoxOfficeItem = newItem
        setNeedsUpdateConfiguration()
    }
    
    override var configurationState: UICellConfigurationState {
        var state = super.configurationState
        
        state.dailyBoxOfficeItem = self.dailyBoxOfficeItem
        
        return state
    }
}

extension BoxOfficeListCell {
    func setupViewsIfNeeded() {
        guard boxOfficeTypeConstraints == nil else { return }
        
        [rankStackView, boxOfficeListContentView].forEach {
            contentView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        let constraints = (leading:
                            rankStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
                           trailing:
                            boxOfficeListContentView.trailingAnchor.constraint(equalTo:
                                                                        contentView.trailingAnchor))
        
        NSLayoutConstraint.activate([
            rankStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            rankStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
            rankStackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            rankStackView.widthAnchor.constraint(equalToConstant: 40),
            
            boxOfficeListContentView.topAnchor.constraint(equalTo: contentView.topAnchor),
            boxOfficeListContentView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            boxOfficeListContentView.leadingAnchor.constraint(equalTo: rankStackView.trailingAnchor, constant: 4),
            boxOfficeListContentView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            constraints.leading,
            constraints.trailing
        ])
        
        boxOfficeTypeConstraints = constraints
    }
    
    override func updateConfiguration(using state: UICellConfigurationState) {
        setupViewsIfNeeded()
        
        var content = defaultBoxOfficeConfiguration().updated(for: state)
        
        content.text = state.dailyBoxOfficeItem?.movieName
        content.textProperties.numberOfLines = 1
        content.secondaryText = "오늘 \(state.dailyBoxOfficeItem?.audienceCount.applyNumberFormatter() ?? "0") / 총 \( state.dailyBoxOfficeItem?.audienceAccumulation.applyNumberFormatter() ?? "0")"
        content.secondaryTextProperties.font = .preferredFont(forTextStyle: .callout)
        
        rankStackView.rankLabel.text = state.dailyBoxOfficeItem?.rank
        configureRankInfoText(state: state)
        
        boxOfficeListContentView.configuration = content
    }
    
    func configureRankInfoText(state: UICellConfigurationState) {
        let oldAndNew = state.dailyBoxOfficeItem?.rankOldAndNew
        if oldAndNew == .new {
            rankStackView.rankInfoLabel.textColor = .systemRed
            rankStackView.rankInfoLabel.text = "신작"
        } else {
            guard let rankingIntensity = state.dailyBoxOfficeItem?.rankingIntensity,
                    let variance = Int(rankingIntensity) else { return }
            
            switch variance {
            case ..<0:
                let text = "▼\(variance * -1)"
                rankStackView.rankInfoLabel.textColor = .systemBlue
                rankStackView.rankInfoLabel.attributedText = text.attributeText()
            case 1...:
                let text = "▲\(variance)"
                rankStackView.rankInfoLabel.textColor = .systemRed
                rankStackView.rankInfoLabel.attributedText = text.attributeText()
            default:
                rankStackView.rankInfoLabel.text = "-"
            }
        }
    }
}

extension String {
    static let numberFormatter: NumberFormatter = {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        
        return numberFormatter
    }()
    
    func applyNumberFormatter() -> String {
        guard let value = String.numberFormatter.string(for: Int(self)) else { return "0" }
        
        return value
    }
    
    func attributeText() -> NSMutableAttributedString {
        let attributedString = NSMutableAttributedString(string: self)
        let range = (self as NSString).range(of: String(self.dropFirst(1)))
        attributedString.addAttribute(.foregroundColor, value: UIColor.black, range: range)
        
        return attributedString
    }
}
