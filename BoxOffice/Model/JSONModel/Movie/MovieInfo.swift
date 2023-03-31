//
//  MovieInfo.swift
//  BoxOffice
//
//  Created by kaki, harry on 2023/03/27.
//

struct MovieInfo: Decodable {
    let codeText: String
    let koreanName: String
    let showTimeText: String
    let productionYearText: String
    let openDateText: String
    let nations: [Nation]
    let genres: [Genre]
    let directors: [Director]
    let actors: [Actor]
    let audits: [Audit]

    private enum CodingKeys: String, CodingKey {
        case codeText = "movieCd"
        case koreanName = "movieNm"
        case showTimeText = "showTm"
        case productionYearText = "prdtYear"
        case openDateText = "openDt"
        case nations
        case genres
        case directors
        case actors
        case audits
    }
}
