//
//  TextMaker.swift
//  BoxOffice
//
//  Created by Muri, Rowan on 2023/04/05.
//

import UIKit

struct TextMaker {
    let data: DailyBoxOfficeMovie
    
    var movieTitle: String {
        return data.movieName
    }
    
    var audienceCount: String {
        let todayAudience = data.audienceCountOfDate.decimal() ?? Sign.zero
        let accumulatedAudience = data.accumulatedAudienceCount.decimal() ?? Sign.zero
        let textformat = "오늘 %@ / 총 %@"
        
        return String(format: textformat, todayAudience, accumulatedAudience)
    }
    
    var rank: String {
        return data.rank
    }
    
    var rankDifference: String {
        switch data.rankOldAndNew {
        case .new:
            return Sign.newMovie
        case .old:
            if data.rankDifference.contains(Sign.minus) {
                let difference = data.rankDifference.trimmingCharacters(in: ["-"])
                
                return Sign.down + difference
            } else if data.rankDifference == Sign.zero {
                return Sign.minus
            } else {
                return Sign.up + data.rankDifference
            }
        }
    }
    
    var rankOldAndNew: RankOldAndNew {
        return data.rankOldAndNew
    }
    
    private enum Sign {
        static let newMovie = "신작"
        static let minus = "-"
        static let zero = "0"
        static let down = "⏷"
        static let up = "⏶"
    }
}
