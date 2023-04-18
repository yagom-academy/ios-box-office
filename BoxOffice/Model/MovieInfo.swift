//
//  MovieInfo.swift
//  BoxOffice
//
//  Created by Christy, Hyemory on 2023/03/22.
//

import Foundation

struct MovieInfo: Codable {
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

    private enum CodingKeys: String, CodingKey {
        case movieCode = "movieCd"
        case movieName = "movieNm"
        case showTime = "showTm"
        case productionYear = "prdtYear"
        case openDate = "openDt"
        case nations
        case genres
        case directors
        case actors
        case audits
    }
}

// MARK: - Actor
struct Actor: Codable {
    let name: String
    
    private enum CodingKeys: String, CodingKey {
        case name = "peopleNm"
    }
}

// MARK: - Audit
struct Audit: Codable {
    let watchGradeName: String
    
    private enum CodingKeys: String, CodingKey {
        case watchGradeName = "watchGradeNm"
    }
}

// MARK: - Director
struct Director: Codable {
    let name: String
    
    private enum CodingKeys: String, CodingKey {
        case name = "peopleNm"
    }
}

// MARK: - Genre
struct Genre: Codable {
    let name: String
    
    private enum CodingKeys: String, CodingKey {
        case name = "genreNm"
    }
}

// MARK: - Nation
struct Nation: Codable {
    let name: String
    
    private enum CodingKeys: String, CodingKey {
        case name = "nationNm"
    }
}
