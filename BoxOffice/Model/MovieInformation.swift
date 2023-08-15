//
//  MovieInformation.swift
//  BoxOffice
//
//  Created by 훈민트 on 2023/08/15.
//

import Foundation

struct MovieInformation: Decodable {
    let movieInformationResult: MovieInformationResult
    
    enum CodingKeys: String, CodingKey {
        case movieInformationResult = "movieInfoResult"
    }
}

struct MovieInformationResult: Decodable {
    let detailMovieInformation: DetailMovieInformation
    let source: String
    
    enum CodingKeys: String, CodingKey {
        case detailMovieInformation = "movieInfo"
        case source
    }
}

struct DetailMovieInformation: Decodable {
    let movieCode: String
    let movieName: String
    let movieEnglishName: String
    let movieOriginalName: String
    let showTime: String
    let productYear: String
    let openDate: String
    let productStatus: String
    let typeName: String
    let nations: [Nation]
    let genres: [Genre]
    let directors: [Director]
    let actors: [Actor]
    let showTypes: [ShowType]
    let companys: [Company]
    let audits: [Audit]
    let staffs: [Staff]

    enum CodingKeys: String, CodingKey {
        case movieCode = "movieCd"
        case movieName = "movieNm"
        case movieEnglishName = "movieNmEn"
        case movieOriginalName = "movieNmOg"
        case showTime = "showTm"
        case productYear = "prdtYear"
        case openDate = "openDt"
        case productStatus = "prdtStatNm"
        case typeName = "typeNm"
        case nations, genres, directors, actors, showTypes, companys, audits, staffs
    }
}

struct Actor: Decodable {
    let name: String
    let englishName: String
    let cast: String
    let englishCast: String
    
    enum CodingKeys: String, CodingKey {
        case name = "peopleNm"
        case englishName = "peopleNmEn"
        case cast
        case englishCast = "castEn"
    }
}

struct Audit: Decodable {
    let auditNumber: String
    let watchGrade: String
    
    enum CodingKeys: String, CodingKey {
        case auditNumber = "auditNo"
        case watchGrade = "watchGradeNm"
    }
}

struct Company: Decodable {
    let code: String
    let name: String
    let englishName: String
    let partName: String

    enum CodingKeys: String, CodingKey {
        case code = "companyCd"
        case name = "companyNm"
        case englishName = "companyNmEn"
        case partName = "companyPartNm"
    }
}

struct Director: Decodable {
    let name: String
    let englishName: String
    
    enum CodingKeys: String, CodingKey {
        case name = "peopleNm"
        case englishName = "peopleNmEn"
    }
}

struct Genre: Decodable {
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case name = "genreNm"
    }
}

struct Nation: Decodable {
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case name = "nationNm"
    }
}

struct ShowType: Decodable {
    let groupName: String
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case groupName = "showTypeGroupNm"
        case name = "showTypeNm"
    }
}

struct Staff: Decodable {
    let name: String
    let englishName: String
    let roleName: String
    
    enum CodingKeys: String, CodingKey {
        case name = "peopleNm"
        case englishName = "peopleNmEn"
        case roleName = "staffRoleNm"
    }
}
