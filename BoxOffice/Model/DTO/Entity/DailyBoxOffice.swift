//
//  DailyBoxOfficeData.swift
//  BoxOffice
//
//  Created by kyungmin, Erick on 2023/08/01.
//

import UIKit

typealias RankStateColor = (targetString: String, color: UIColor)

struct DailyBoxOffice {
    let rank: String
    let rankState: String
    let movieTitle: String
    let dailyAndTotalAudience: String
    let rankStateColor: RankStateColor
}
