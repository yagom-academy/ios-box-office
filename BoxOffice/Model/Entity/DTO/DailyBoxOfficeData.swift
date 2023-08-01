//
//  DailyBoxOfficeData.swift
//  BoxOffice
//
//  Created by kyungmin, Erick on 2023/08/01.
//

import UIKit

typealias RankStateColor = (targetString: String, color: UIColor)

struct DailyBoxOfficeData {
    let rank: String
    let rankState: String
    let movieTitle: String
    let dailyAndTotalAudience: String
    
    var rankStateColor: RankStateColor {
        if rankState == "신작" {
            return ("신작", .systemRed)
        } else if rankState.contains("▼") {
            return ("▼", .systemBlue)
        } else {
            return ("▲", .systemRed)
        }
    }
}
