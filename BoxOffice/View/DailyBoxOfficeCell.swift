//
//  DailyBoxOfficeCell.swift
//  BoxOffice
//
//  Created by Muri, Rowan on 2023/03/27.
//

import UIKit

final class DailyBoxOfficeCell: UICollectionViewListCell, Identifiable {
    var dailyBoxOfficeData: DailyBoxOfficeMovie?
    var rankLabel = UILabel()
    var rankDifferenceLabel = UILabel()
    var isConstraintNeeded = true
    var dailyBoxOfficeListContentView = UIListContentView(configuration: UIListContentConfiguration.subtitleCell())
    
    func update(with newDailyBoxOfficeData: DailyBoxOfficeMovie) {
        guard dailyBoxOfficeData != newDailyBoxOfficeData else { return }
        
        dailyBoxOfficeData = newDailyBoxOfficeData
        setLayoutConstraint()
    }
    
    override var configurationState: UICellConfigurationState {
        var state = super.configurationState
        state.dailyBoxOfficeData = self.dailyBoxOfficeData
        
        return state
    }
    
    func setLayoutConstraint() {
        guard self.isConstraintNeeded else { return }
        
        let rankStackView = {
            let stackView = UIStackView()
            stackView.axis = .vertical
            stackView.addArrangedSubview(rankLabel)
            stackView.addArrangedSubview(rankDifferenceLabel)
            
            return stackView
        }()
        
        [dailyBoxOfficeListContentView, rankStackView].forEach {
            self.contentView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            rankStackView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 30),
            rankStackView.trailingAnchor.constraint(equalTo: dailyBoxOfficeListContentView.leadingAnchor),
            rankStackView.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            dailyBoxOfficeListContentView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            dailyBoxOfficeListContentView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
            dailyBoxOfficeListContentView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor)
        ])
        
        self.isConstraintNeeded = false
    }
    
    override func updateConfiguration(using state: UICellConfigurationState) {
        setLayoutConstraint()
        
        var content = defaultContentConfiguration().updated(for: state)
        content.text = state.dailyBoxOfficeData?.movieName
        content.textProperties.font = UIFont.preferredFont(forTextStyle: .title3)
        content.secondaryText = "\(state.dailyBoxOfficeData!.audienceCountOfDate), \(state.dailyBoxOfficeData!.accumulatedAudienceCount)"
        content.secondaryTextProperties.font = UIFont.preferredFont(forTextStyle: .body)
        dailyBoxOfficeListContentView.configuration = content
        
        rankLabel.text = state.dailyBoxOfficeData?.rank ?? "0"
        rankLabel.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        rankDifferenceLabel.text = state.dailyBoxOfficeData?.rankDifference ?? "0"
        rankDifferenceLabel.font = UIFont.preferredFont(forTextStyle: .body)
    }
}

private extension UIConfigurationStateCustomKey {
    static let dailyBoxOffice = UIConfigurationStateCustomKey("dailyBoxOffice")
}

extension UIConfigurationState {
    var dailyBoxOfficeData: DailyBoxOfficeMovie? {
        get { return self[.dailyBoxOffice] as? DailyBoxOfficeMovie }
        set { self[.dailyBoxOffice] = newValue }
    }
}
