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
    let movieEnglishName: String
    let movieOriginalName: String
    let showTime: String
    let productionYear: String
    let openDate: String
    let productionStateName: String
    let typeName: String
    let nations: [Nation]
    let genres: [Genre]
    let directors: [Director]
    let actors: [Actor]
    let showTypes: [ShowType]
    let companys: [Company]
    let audits: [Audit]
    let staffs: [Staff]

    private enum CodingKeys: String, CodingKey {
        case movieCode = "movieCd"
        case movieName = "movieNm"
        case movieEnglishName = "movieNmEn"
        case movieOriginalName = "movieNmOg"
        case showTime = "showTm"
        case productionYear = "prdtYear"
        case openDate = "openDt"
        case productionStateName = "prdtStatNm"
        case typeName = "typeNm"
        case nations
        case genres
        case directors
        case actors
        case showTypes
        case companys
        case audits
        case staffs
    }
}

// MARK: - Actor
struct Actor: Codable {
    let name: String
    let englishName: String
    let castName: String
    let castEnglishName: String
    
    private enum CodingKeys: String, CodingKey {
        case name = "peopleNm"
        case englishName = "peopleNmEn"
        case castName = "cast"
        case castEnglishName = "castEn"
    }
}

// MARK: - Audit
struct Audit: Codable {
    let auditNumber: String
    let watchGradeName: String
    
    private enum CodingKeys: String, CodingKey {
        case auditNumber = "auditNo"
        case watchGradeName = "watchGradeNm"
    }
}

// MARK: - Company
struct Company: Codable {
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

// MARK: - Director
struct Director: Codable {
    let name: String
    let englishName: String
    
    private enum CodingKeys: String, CodingKey {
        case name = "peopleNm"
        case englishName = "peopleNmEn"
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

// MARK: - ShowType
struct ShowType: Codable {
    let groupName: String
    let name: String
    
    private enum CodingKeys: String, CodingKey {
        case groupName = "showTypeGroupNm"
        case name = "showTypeNm"
    }
}

// MARK: - Staff
struct Staff: Codable {
    let name: String
    let englishName: String
    let roleName: String
    
    private enum CodingKeys: String, CodingKey {
        case name = "peopleNm"
        case englishName = "peopleNmEn"
        case roleName = "staffRoleNm"
    }
}
