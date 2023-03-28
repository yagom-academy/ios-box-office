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
        
        [boxOfficeListContentView, rankStackView].forEach {
            contentView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        let constraints = (leading:
                            rankStackView.leadingAnchor.constraint(greaterThanOrEqualTo:
                                                                    boxOfficeListContentView.trailingAnchor),
                           trailing:
                            rankStackView.trailingAnchor.constraint(equalTo:
                                                                        contentView.trailingAnchor))
        
        NSLayoutConstraint.activate([
            boxOfficeListContentView.topAnchor.constraint(equalTo: contentView.topAnchor),
            boxOfficeListContentView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            boxOfficeListContentView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            rankStackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            constraints.leading,
            constraints.trailing
        ])
        
        boxOfficeTypeConstraints = constraints
    }
    
    override func updateConfiguration(using state: UICellConfigurationState) {
        setupViewsIfNeeded()
        
        var content = defaultBoxOfficeConfiguration().updated(for: state)
        
        content.text = state.dailyBoxOfficeItem?.movieName
        content.secondaryText = "오늘 \(state.dailyBoxOfficeItem?.audienceCount ?? "0") / 총 \( state.dailyBoxOfficeItem?.audienceAccumulation ?? "0")"
        
        boxOfficeListContentView.configuration = content
    }
}
