//
//  MovieDetail.swift
//  BoxOffice
//
//  Created by goat, songjun on 2023/03/21.
//

import Foundation

struct MovieDetail: Decodable {
    let movieInfoResult: MovieInfoResult
}

struct MovieInfoResult: Decodable {
    let movieCode: String
    let movieName: String
    let movieNameEnglish: String
    let originalMovieName: String
    let showTime: String
    let productYear: String
    let openDate: String
    let productStateName: String
    let movieTypeName: String
    let nations: [Nation]
    let genres: [Genre]
    let directors: [Director]
    let actors: [Actor]
    let showType: [ShowType]
    let companys: [Company]
    let audits: [Audit]
    let staffs: [Staff]
    let source: String
    
    private enum CodingKeys: String, CodingKey {
        case movieCode = "movieCd"
        case movieName = "movieNm"
        case movieNameEnglish = "moviewNmEn"
        case originalMovieName = "movieNmOg"
        case showTime = "showTm"
        case productYear = "prdtYear"
        case openDate = "openDt"
        case productStateName = "prdtStatNm"
        case movieTypeName = "typeNm"
        case nations
        case genres
        case directors
        case actors
        case showType
        case companys
        case audits
        case staffs
        case source
        
    }
}

struct Nation: Decodable {
    let nationName: String
    
    private enum CodingKeys: String, CodingKey {
        case nationName = "nationNm"
    }
}

struct Genre: Decodable {
    let genreName: String
    
    private enum CodingKeys: String, CodingKey {
        case genreName = "genreNm"
    }
}

struct Director: Decodable {
    let peopleName: String
    let peopleNameEnglish: String
    
    private enum CodingKeys: String, CodingKey {
        case peopleName = "peopleNm"
        case peopleNameEnglish = "peopleNmEn"
    }
}

struct Actor: Decodable {
    let peopleName: String
    let peopleNameEnglish: String
    let cast: String
    let caseEnglish: String
    
    private enum CodingKeys: String, CodingKey {
        case peopleName = "peopleNm"
        case peopleNameEnglish = "peopleNmEn"
        case cast
        case caseEnglish = "caseEn"
    }
    
}

struct ShowType: Decodable {
    let showTypeGroupName: String
    let showTypeName: String
    
    private enum CodingKeys: String, CodingKey {
        case showTypeGroupName = "showTypeGroupNm"
        case showTypeName = "showTypeNm"
    }
}

struct Company: Decodable {
    let companyCode: String
    let companyName: String
    let companyNameEnglish: String
    let companyPartName: String
    
    private enum CodingKeys: String, CodingKey {
        case companyCode = "companyCd"
        case companyName = "companyNm"
        case companyNameEnglish = "companyNmEn"
        case companyPartName = "companyPartNm"
    }
}

struct Audit: Decodable {
    let auditNumber: String
    let watchGradeName: String
    
    private enum CodingKeys: String, CodingKey {
        case auditNumber = "auditNo"
        case watchGradeName = "watchGradeNm"
        
    }
}

struct Staff: Decodable {
    let peopleName: String
    let peopleNameEnglish: String
    let staffRoleName: String
    
    private enum CodingKeys: String, CodingKey {
        case peopleName = "peopleNm"
        case peopleNameEnglish = "peopleNmEn"
        case staffRoleName = "staffRoleNm"

    }
}

