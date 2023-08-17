//
//  Item.swift
//  BoxOffice
//
//  Created by Kobe, yyss99 on 2023/08/10.
//

import Foundation

struct Item: Hashable {
    let rankNumber: String?
    let rankIntensity: String?
    let movieName: String?
    let audienceCount: String?
    let audienceAccumulated: String?
    let rankOldAndNew: String?
    
    init(rankNumber: String? = nil, rankIntensity: String? = nil, movieName: String? = nil, audienceCount: String? = nil, audienceAccumulated: String? = nil, rankOldAndNew: String? = nil) {
        self.rankNumber = rankNumber
        self.rankIntensity = rankIntensity
        self.movieName = movieName
        self.audienceCount = audienceCount
        self.audienceAccumulated = audienceAccumulated
        self.rankOldAndNew = rankOldAndNew
    }
    
    private let identifier = UUID()
    
    static var all: [Item] = []
}
