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
                            rankStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                           trailing:
                            boxOfficeListContentView.trailingAnchor.constraint(equalTo:
                                                                        contentView.trailingAnchor))
        
        NSLayoutConstraint.activate([
            rankStackView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 12),
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
        content.secondaryText = "오늘 \(state.dailyBoxOfficeItem?.audienceCount ?? "0") / 총 \( state.dailyBoxOfficeItem?.audienceAccumulation ?? "0")"
        content.secondaryTextProperties.font = .preferredFont(forTextStyle: .callout)
        
        rankStackView.rankLabel.text = state.dailyBoxOfficeItem?.rank
        rankStackView.rankInfoLabel.text = state.dailyBoxOfficeItem?.rankOldAndNew.rawValue
        
        boxOfficeListContentView.configuration = content
    }
}
