//
//  BoxOfficeResult.swift
//  BoxOffice
//
//  Created by 레옹아범 ,Andrew on 2023/03/20.
//

struct BoxOfficeResult: Decodable {
    let boxofficeType: String
    let dateRange: String
    let movies: [MovieInfo]
    
    enum CodingKeys: String, CodingKey {
        case boxofficeType
        case dateRange = "showRange"
        case movies = "dailyBoxOfficeList"
    }
}
