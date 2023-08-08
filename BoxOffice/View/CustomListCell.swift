//
//  CustomListCell.swift
//  BoxOffice
//
//  Created by Minseong Kang on 2023/08/08.
//

import UIKit

class CustomListCell: UICollectionViewListCell {
    private var item: DailyBoxOfficeList? = nil
    
    override var configurationState: UICellConfigurationState {
        var state = super.configurationState
        state.item = self.item
        return state
    }
    
    func updateWithItem(_ newItem: DailyBoxOfficeList) {
        guard item != newItem else { return }
        
        item = newItem
        
        setNeedsUpdateConfiguration()
    }
}
