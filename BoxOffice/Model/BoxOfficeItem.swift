//
//  BoxOfficeItem.swift
//  BoxOffice
//
//  Created by vetto, brody on 23/03/27.
//

import UIKit

struct BoxOfficeItem: Hashable {
    let identifier = UUID()
    let rank: String
    let rankIncrement: String
    let title: String
    let audienceCount: String
    let audienceAccumulation: String
    
    init(rank: String, rankIncrement: String, title: String, audienceCount: String, audienceAccumulation: String) {
        self.rank = rank
        self.rankIncrement = rankIncrement
        self.title = title
        self.audienceCount = audienceCount
        self.audienceAccumulation = audienceAccumulation
    }
}
