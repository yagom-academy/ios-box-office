//
//  BoxOfficeListCell.swift
//  BoxOffice
//
//  Created by vetto, brody on 23/03/27.
//

import UIKit

final class BoxOfficeListCell: UICollectionViewListCell {
    var item: BoxOfficeItem?
    
    override func updateConfiguration(using state: UICellConfigurationState) {
        var newConfiguration = BoxOfficeContentConfiguration().updated(for: state)
        
        newConfiguration.rank = item?.rank
        newConfiguration.rankIncrement = item?.rankIncrement
        newConfiguration.rankOldAndNew = item?.rankOldAndNew
        newConfiguration.title = item?.title
        newConfiguration.audienceCount = item?.audienceCount
        newConfiguration.audienceAccumulationCount = item?.audienceAccumulationCount
        
        contentConfiguration = newConfiguration
    }
}
