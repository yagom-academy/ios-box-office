//
//  Movie.swift
//  BoxOffice
//
//  Created by kaki, harry on 2023/03/21.
//

struct Movie: Codable {
    let movieInfoResult: MovieInfoResult
}

struct MovieInfoResult: Codable {
    let movieInfo: MovieInfo
    let source: String
}

struct MovieInfo: Codable {
    let movieCode, movieKoreanName, movieEnglishName, movieOriginalName: String
    let showTime, productionYear, openDate, productionStateName: String
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
        case movieKoreanName = "movieNm"
        case movieEnglishName = "movieNmEn"
        case movieOriginalName = "movieNmOg"
        case showTime = "showTm"
        case productionYear = "prdtYear"
        case openDate = "openDt"
        case productionStateName = "prdtStatNm"
        case typeName = "typeNm"
        case nations, genres, directors, actors, showTypes, companys, audits, staffs
    }
}

struct Actor: Codable {
    let peopleName, peopleEnglishName, castName, castEnglishName: String
    
    enum CodingKeys: String, CodingKey {
        case peopleName = "peopleNm"
        case peopleEnglishName = "peopleNmEn"
        case castName = "cast"
        case castEnglishName = "castEn"
    }
}

struct Audit: Codable {
    let auditNumber, watchGradeName: String
    
    enum CodingKeys: String, CodingKey {
        case auditNumber = "auditNo"
        case watchGradeName = "watchGradeNm"
    }
}

struct Company: Codable {
    let companyCode, companyName, companyEnglishName, companyPartName: String

    enum CodingKeys: String, CodingKey {
        case companyCode = "companyCd"
        case companyName = "companyNm"
        case companyEnglishName = "companyNmEn"
        case companyPartName = "companyPartNm"
    }
}

struct Director: Codable {
    let peopleName, peopleEnglishName: String
    
    enum CodingKeys: String, CodingKey {
        case peopleName = "peopleNm"
        case peopleEnglishName = "peopleNmEn"
    }
}

struct Genre: Codable {
    let genreName: String
    
    enum CodingKeys: String, CodingKey {
        case genreName = "genreNm"
    }
}

struct Nation: Codable {
    let nationName: String
    
    enum CodingKeys: String, CodingKey {
        case nationName = "nationNm"
    }
}

struct ShowType: Codable {
    let showTypeGroupName, showTypeName: String
    
    enum CodingKeys: String, CodingKey {
        case showTypeGroupName = "showTypeGroupNm"
        case showTypeName = "showTypeNm"
    }
}

struct Staff: Codable {
    let peopleName, peopleEnglishName, staffRoleName: String
    
    enum CodingKeys: String, CodingKey {
        case peopleName = "peopleNm"
        case peopleEnglishName = "peopleNmEn"
        case staffRoleName = "staffRoleNm"
    }
}
