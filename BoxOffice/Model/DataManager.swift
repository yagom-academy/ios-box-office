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
            var rankStateColor: RankStateColor
            
            if $0.rankOldAndNew == "NEW" {
                rankState = "신작"
                rankStateColor = ("신작", .systemRed)
            } else if $0.rankIntensity == "0" {
                rankState = "0"
                rankStateColor = ("0", .black)
            } else if $0.rankIntensity.contains("-") {
                rankState = $0.rankIntensity.replacingOccurrences(of: "-", with: "▼")
                rankStateColor = ("▼", .systemBlue)
            } else {
                rankState = "▲" + $0.rankIntensity
                rankStateColor = ("▲", .systemRed)
            }
            
            return DailyBoxOfficeData(rank: $0.rank, rankState: rankState, movieTitle: $0.movieName, dailyAndTotalAudience: dailyAndTotalAudience, rankStateColor: rankStateColor)
        }
    }
}
