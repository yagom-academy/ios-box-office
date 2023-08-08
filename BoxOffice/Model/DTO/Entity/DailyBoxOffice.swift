//
//  DailyBoxOffice.swift
//  BoxOffice
//
//  Created by kyungmin, Erick on 2023/08/01.
//

import UIKit

typealias RankStateColor = (targetString: String, color: UIColor)

struct DailyBoxOffice: Hashable {
    let movieCode: String
    let rank: String
    let rankState: String
    let movieTitle: String
    let dailyAndTotalAudience: String
    let rankStateColor: RankStateColor
    
    static func == (lhs: DailyBoxOffice, rhs: DailyBoxOffice) -> Bool {
        return lhs.movieCode == rhs.movieCode
            && lhs.rank == rhs.rank
            && lhs.rankState == rhs.rankState
            && lhs.movieTitle == rhs.movieTitle
            && lhs.dailyAndTotalAudience == rhs.dailyAndTotalAudience
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(movieCode)
        hasher.combine(rank)
        hasher.combine(rankState)
        hasher.combine(movieTitle)
        hasher.combine(dailyAndTotalAudience)
    }
}
