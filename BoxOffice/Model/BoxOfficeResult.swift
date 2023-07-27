//
//  BoxOfficeResult.swift
//  BoxOffice
//
//  Created by karen on 2023/07/26.
//

struct BoxOfficeResult: Decodable {
    let boxOfficeType: String
    let dateRange: String
    let movies: [MovieInfo]

    private enum CodingKeys: String, CodingKey {
        case boxOfficeType
        case dateRange = "showRange" 
        case movies = "dailyBoxOfficeList"
    }
}
