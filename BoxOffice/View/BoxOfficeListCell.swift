//
//  BoxOfficeListCell.swift
//  BoxOffice
//
//  Created by Christy, Hyemory on 2023/03/28.
//

import UIKit

extension UIConfigurationStateCustomKey {
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
    private let rankStackView = UIStackView()
    private lazy var boxOfficeListContentView = UIListContentView(configuration: defaultBoxOfficeConfiguration())
    
    private let rankLabel: UILabel = {
        let label = UILabel()
        
        label.font = .preferredFont(forTextStyle: .title1)
        
        return label
    }()
    
    private let rankInfoLabel: UILabel = {
        let label = UILabel()
        
        label.font = .preferredFont(forTextStyle: .caption1)
        
        return label
    }()
    
    private func defaultBoxOfficeConfiguration() -> UIListContentConfiguration {
        return .subtitleCell()
    }

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

// MARK: - configure UI

extension BoxOfficeListCell {
    enum RankInfo {
        case new
        case noChange
        case increase(Int)
        case decrease(Int)
        
        var description: String {
            switch self {
            case .new:
                return "신작"
            case .noChange:
                return "-"
            case .increase(let variance):
                return "▲\(variance)"
            case .decrease(let variance):
                return "▼\(variance * -1)"
            }
        }
        
        var fontColor: UIColor {
            switch self {
            case .new:
                return .systemRed
            case .noChange:
                return .black
            case .increase:
                return .systemRed
            case .decrease:
                return .systemBlue
            }
        }
    }
    
    private func configureRankStackView() {
        rankStackView.translatesAutoresizingMaskIntoConstraints = false
        rankStackView.axis = .vertical
        rankStackView.alignment = .center
        
        rankStackView.addArrangedSubview(rankLabel)
        rankStackView.addArrangedSubview(rankInfoLabel)
    }
    
    private func setupViewsIfNeeded() {
        configureRankStackView()
        
        [rankStackView, boxOfficeListContentView].forEach {
            contentView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            rankStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            rankStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            rankStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
            rankStackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            rankStackView.widthAnchor.constraint(equalToConstant: 40),
            
            boxOfficeListContentView.trailingAnchor.constraint(equalTo:
                                                        contentView.trailingAnchor),
            boxOfficeListContentView.topAnchor.constraint(equalTo: contentView.topAnchor),
            boxOfficeListContentView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            boxOfficeListContentView.leadingAnchor.constraint(equalTo: rankStackView.trailingAnchor, constant: 4),
            boxOfficeListContentView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }
    
    override func updateConfiguration(using state: UICellConfigurationState) {
        setupViewsIfNeeded()
        
        let numberFormatter = NumberFormatter()
        var content = defaultBoxOfficeConfiguration().updated(for: state)
        
        numberFormatter.numberStyle = .decimal
        
        content.text = state.dailyBoxOfficeItem?.movieName
        content.textProperties.numberOfLines = 1
        content.secondaryText = "오늘 \(state.dailyBoxOfficeItem?.audienceCount.applyNumberFormatter(formatter: numberFormatter) ?? "0") / 총 \( state.dailyBoxOfficeItem?.audienceAccumulation.applyNumberFormatter(formatter: numberFormatter) ?? "0")"
        content.secondaryTextProperties.font = .preferredFont(forTextStyle: .callout)
        
        rankLabel.text = state.dailyBoxOfficeItem?.rank
        configureRankInfoLabel(state: state)
        
        boxOfficeListContentView.configuration = content
    }
    
    private func configureRankInfoLabel(state: UICellConfigurationState) {
        let oldAndNew = state.dailyBoxOfficeItem?.rankOldAndNew
        
        if oldAndNew == .new {
            rankInfoLabel.textColor = RankInfo.new.fontColor
            rankInfoLabel.text = RankInfo.new.description
        } else {
            guard let rankingIntensity = state.dailyBoxOfficeItem?.rankingIntensity,
                    let variance = Int(rankingIntensity) else { return }
            
            switch variance {
            case ..<0:
                rankInfoLabel.textColor = RankInfo.decrease(variance).fontColor
                rankInfoLabel.attributedText = RankInfo.decrease(variance).description.attributeText()
            case 1...:
                rankInfoLabel.textColor = RankInfo.increase(variance).fontColor
                rankInfoLabel.attributedText = RankInfo.increase(variance).description.attributeText()
            default:
                rankInfoLabel.textColor = RankInfo.noChange.fontColor
                rankInfoLabel.text = RankInfo.noChange.description
            }
        }
    }
}

// MARK: - variance String extension

extension String {
    func attributeText() -> NSMutableAttributedString {
        let attributedString = NSMutableAttributedString(string: self)
        let range = (self as NSString).range(of: String(self.dropFirst(1)))
        
        attributedString.addAttribute(.foregroundColor, value: UIColor.black, range: range)
        
        return attributedString
    }
}
