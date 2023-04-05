//
//  DailyBoxOfficeItem.swift
//  BoxOffice
//
//  Created by 리지, kokkilE on 2023/04/05.
//

import Foundation

struct DailyBoxOfficeItem: Hashable {
    let identifier = UUID()
    let rank: String
    let rankVariance: String
    let rankOldAndNew: String
    let code: String
    let name: String
    let audienceCount: String
    let audienceAccumulation: String
    
    init(from movie: DailyBoxOffice.BoxOfficeResult.Movie) {
        self.rank = movie.rank
        self.rankVariance = movie.rankVariance
        self.rankOldAndNew = movie.rankOldAndNew
        self.code = movie.code
        self.name = movie.name
        self.audienceCount = movie.audienceCount
        self.audienceAccumulation = movie.audienceAccumulation
    }
}
