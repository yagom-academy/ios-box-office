//
//  DataManager.swift
//  BoxOffice
//
//  Created by karen on 2023/07/28.
//

import UIKit

struct DataManager {
    private let date: Date
    private let apiType: KobisAPIType
    let boxOfficeDecoder: BoxOfficeDecoder<DailyBoxOffice>
    var movieItems: [BoxOfficeMovieInfo] = []
    
    var navigationTitleText: String {
        return Date.dateFormatter.string(from: date)
    }

    init(date: Date) {
        let dataText = Date.apiDateFormatter.string(from: date)
        self.date = date
        self.apiType = KobisAPIType.boxOffice(dataText)
        self.boxOfficeDecoder = BoxOfficeDecoder<DailyBoxOffice>(apiType: self.apiType, model: NetworkManager(session: .shared))
    }
}
