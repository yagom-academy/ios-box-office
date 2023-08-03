//
//  DataManager.swift
//  BoxOffice
//
//  Created by kyungmin, Erick on 2023/08/02.
//

import Foundation

enum DataManager {
    static func boxOfficeTransferDailyBoxOfficeData(boxOffice: BoxOffice) -> [DailyBoxOfficeData] {
        return boxOffice.boxOfficeResult.dailyBoxOfficeList.map {
            let decimalAudienceCount = NumberFormatter().bringDecimalString($0.audienceCount)
            let decimalaudienceAccumulation = NumberFormatter().bringDecimalString($0.audienceAccumulation)
            let dailyAndTotalAudience = String(format: NameSpace.dailyAndTotalAudience, decimalAudienceCount, decimalaudienceAccumulation)
            
            var rankState = NameSpace.empty
            var rankStateColor: RankStateColor
            
            if $0.rankOldAndNew == NameSpace.new {
                rankState = NameSpace.newMovie
                rankStateColor = (NameSpace.newMovie, .systemRed)
            } else if $0.rankIntensity == NameSpace.zero {
                rankState = NameSpace.minus
                rankStateColor = (NameSpace.minus, .black)
            } else if $0.rankIntensity.contains(NameSpace.minus) {
                rankState = $0.rankIntensity.replacingOccurrences(of: NameSpace.minus, with: NameSpace.downTriangle)
                rankStateColor = (NameSpace.downTriangle, .systemBlue)
            } else {
                rankState = NameSpace.upTriangle + $0.rankIntensity
                rankStateColor = (NameSpace.upTriangle, .systemRed)
            }
            
            return DailyBoxOfficeData(rank: $0.rank, rankState: rankState, movieTitle: $0.movieName, dailyAndTotalAudience: dailyAndTotalAudience, rankStateColor: rankStateColor)
        }
    }
}

extension DataManager {
    enum NameSpace {
        static let dailyAndTotalAudience = "오늘 %@ / 총 %@"
        static let empty = ""
        static let new = "NEW"
        static let old = "OLD"
        static let newMovie = "신작"
        static let zero = "0"
        static let minus = "-"
        static let upTriangle = "▲"
        static let downTriangle = "▼"
    }
}
