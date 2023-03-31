//
//  MovieInfoItem.swift
//  BoxOffice
//
//  Created by Seoyeon Hong on 2023/03/21.
//

import Foundation

struct MovieInfoItem: Decodable {
    let movieInfoResult: MovieInfoResult
}

struct MovieInfoResult: Decodable {
    let movieInfo: MovieInfo
}

struct MovieInfo: Decodable {
    let movieCode: String
    let movieName: String
    let showTime: String
    let productionYear: String
    let openDate: String
    let nations: [Nation]
    let genres: [Genre]
    let directors: [Director]
    let actors: [Actor]
    let audits: [Audit]
    
    enum CodingKeys: String, CodingKey {
        case movieCode = "movieCd"
        case movieName = "movieNm"
        case showTime = "showTm"
        case productionYear = "prdtYear"
        case openDate = "openDt"
        case nations, genres, directors, actors, audits
    }
}

struct Actor: Decodable {
    let actorName: String
    
    enum CodingKeys: String, CodingKey {
        case actorName = "peopleNm"
    }
}

struct Audit: Decodable {
    let watchGradeName: String
    
    enum CodingKeys: String, CodingKey {
        case watchGradeName = "watchGradeNm"
    }
}

struct Director: Decodable {
    let peopleName: String
    
    enum CodingKeys: String, CodingKey {
        case peopleName = "peopleNm"
    }
}

struct Genre: Decodable {
    let genreName: String
    
    enum CodingKeys: String, CodingKey {
        case genreName = "genreNm"
    }
}

struct Nation: Decodable {
    let nationName: String
    
    enum CodingKeys: String, CodingKey {
        case nationName = "nationNm"
    }
}
