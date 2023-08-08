//
//  ItemListCell.swift
//  BoxOffice
//
//  Created by Kobe, yyss99 on 2023/08/08.
//

import UIKit

class ItemListCell: UICollectionViewListCell {
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
