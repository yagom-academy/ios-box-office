//
//  MovieInfomation.swift
//  BoxOffice
//
//  Created by Morgan, Toy on 11/30/23.
//

import Foundation

struct MovieInfomation: Decodable {
    let movieCode: String
    let movieName: String
    let movieEnglishName: String
    let movieOriginalName: String
    let showTime: String
    let productionYear: String
    let openDate: String
    let productionStatusName: String
    let typeName: String
    let nations: [Nation]
    let genres: [Genre]
    let directors: [Director]
    let actors: [ActorDetail]
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
        case productionStatusName = "prdtStatNm"
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

struct ActorDetail: Decodable {
    let personName: String
    let personEnglishName: String
    let cast: String
    let castEnglish: String

    private enum CodingKeys: String, CodingKey {
        case personName = "peopleNm"
        case personEnglishName = "peopleNmEn"
        case cast
        case castEnglish = "castEn"
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
    let companyEnglishName: String
    let companyPartName: String

    private enum CodingKeys: String, CodingKey {
        case companyCode = "companyCd"
        case companyName = "companyNm"
        case companyEnglishName = "companyNmEn"
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
    let personName: String
    let personEnglishName: String
    let staffRoleName: String

    private enum CodingKeys: String, CodingKey {
        case personName = "peopleNm"
        case personEnglishName = "peopleNmEn"
        case staffRoleName = "staffRoleNm"
    }
}
