//
//  BoxOfficeResult.swift
//  BoxOffice
//
//  Created by karen on 2023/07/26.
//

struct BoxOfficeResult: Decodable {
    let boxofficeType: String
    let dateRange: String
    let movies: [MovieInfo]

    private enum CodingKeys: String, CodingKey {
        case boxofficeType
        case dateRange = "showRange" 
        case movies = "dailyBoxOfficeList"
    }
}
