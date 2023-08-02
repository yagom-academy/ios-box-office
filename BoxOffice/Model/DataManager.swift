//
//  DataManager.swift
//  BoxOffice
//
//  Created by kyungmin, Erick on 2023/08/02.
//

import Foundation

enum DataManager {
    static func boxOfficeTransferDailyBoxOfficeData(boxOffice: BoxOffice) -> [DailyBoxOfficeData?] {
        return boxOffice.boxOfficeResult.dailyBoxOfficeList.map {
            guard let decimalAudienceCount = FormatManager.bringDecimalString($0.audienceCount),
                  let decimalaudienceAccumulation = FormatManager.bringDecimalString($0.audienceAccumulation) else {
                return nil
            }
            
            let dailyAndTotalAudience = "오늘 \(decimalAudienceCount) / 총 \(decimalaudienceAccumulation)"
            var rankState = ""
            
            if $0.rankOldAndNew == "NEW" {
                rankState = "신작"
            } else if $0.rankIntensity == "0" {
                rankState = "0"
            } else if $0.rankIntensity.contains("-") {
                var rankIntensity = $0.rankIntensity
                rankIntensity.removeFirst()
                rankState = "▼" + rankIntensity
            } else {
                rankState = "▲" + $0.rankIntensity
            }
            
            return DailyBoxOfficeData(rank: $0.rank, rankState: rankState, movieTitle: $0.movieName, dailyAndTotalAudience: dailyAndTotalAudience)
        }
    }
}
