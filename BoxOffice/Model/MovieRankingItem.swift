//
//  MovieRankingItem.swift
//  BoxOffice
//
//  Created by Seoyeon Hong on 2023/03/28.
//

import Foundation

enum ListSection {
    case main
}

struct ListItem: Hashable {
    let rank: String
    let rankInten: String
    let rankOldandNew: String
    let movieName: String
    let audienceCount: String
    let audienceAcc: String
    let movieCode: String 
}
