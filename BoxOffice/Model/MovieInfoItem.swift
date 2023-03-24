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

struct MovieInfo: Decodable, CustomStringConvertible {
    let movieCode: String
    let movieName: String
    let movieNameEnglish: String
    let showTime: String
    let openDate: String
    let nations: [Nation]
    let genres: [Genre]
    let directors: [Director]
    let actors: [Actor]
    let companys: [Company]
    let audits: [Audit]
    
    enum CodingKeys: String, CodingKey {
        case movieCode = "movieCd"
        case movieName = "movieNm"
        case movieNameEnglish = "movieNmEn"
        case showTime = "showTm"
        case openDate = "openDt"
        case nations, genres, directors, actors, companys, audits
    }
    
    var description: String {
        return """
        영화명: \(movieName) (\(movieNameEnglish))
        영화코드: \(movieCode)
        개봉연도: \(openDate)
        상영시간: \(showTime)
        장르: \(genres.map { $0.genreName }.joined(separator: ", "))
        감독: \(directors.map { $0.peopleName }.joined(separator: ", "))
        배우: \(actors.map { $0.peopleName }.joined(separator: ", "))
        """
    }
}

struct Actor: Decodable {
    let peopleName: String
    
    enum CodingKeys: String, CodingKey {
        case peopleName = "peopleNm"
    }
}

struct Audit: Decodable {
    let watchGradeName: String
    
    enum CodingKeys: String, CodingKey {
        case watchGradeName = "watchGradeNm"
    }
}

struct Company: Decodable {
    let companyName: String
    let companyPartName: String
    
    enum CodingKeys: String, CodingKey {
        case companyName = "companyNm"
        case companyPartName = "companyPartNm"
        
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
