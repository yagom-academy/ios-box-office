//
//  MovieInfoDescObject.swift
//  BoxOffice
//
//  Created by Andrew, 레옹아범 on 2023/03/21.
//

import Foundation

struct MovieInfoDescObject: Decodable {
    let name: String
    let showTime: String
    let productedYear: String
    let directors: [DirectorObject]
    let openDate: String
    let audits: [AuditObject]
    let nations: [NationObject]
    let genre: [GenreObject]
    let actors: [ActorObject]
    
    private enum CodingKeys: String, CodingKey {
        case name = "movieNm"
        case showTime = "showTm"
        case productedYear = "prdtYear"
        case openDate = "openDt"
        case audits = "audits"
        case genre = "genres"
        case directors, nations, actors
    }
}

struct ActorObject: Decodable {
    let name: String
    
    private enum CodingKeys: String, CodingKey {
        case name = "peopleNm"
    }
}

struct GenreObject: Decodable {
    let name: String
    
    private enum CodingKeys: String, CodingKey {
        case name = "genreNm"
    }
}

struct NationObject: Decodable {
    let name: String
    
    private enum CodingKeys: String, CodingKey {
        case name = "nationNm"
    }
}

struct DirectorObject: Decodable {
    let name: String
    
    private enum CodingKeys: String, CodingKey {
        case name = "peopleNm"
    }
}

struct AuditObject: Decodable {
    let watchGradeNm: String
}
