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
    
    private func defaultBoxOfficeConfiguration() -> UIListContentConfiguration {
        return .subtitleCell()
    }
    
    private lazy var boxOfficeListContentView = UIListContentView(configuration: defaultBoxOfficeConfiguration())
    
    override var configurationState: UICellConfigurationState {
        var state = super.configurationState
        
        state.dailyBoxOfficeItem = self.dailyBoxOfficeItem
        
        return state
    }
}
