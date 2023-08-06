//
//  BoxOfficeResult.swift
//  BoxOffice
//
//  Created by karen on 2023/07/26.
//

struct BoxOfficeResult: Decodable {
    let boxOfficeType: String
    let dateRange: String
    let movies: [BoxOfficeMovieInfo]

    private enum CodingKeys: String, CodingKey {
        case boxOfficeType = "boxofficeType"
        case dateRange = "showRange"
        case movies = "dailyBoxOfficeList"
    }
}
