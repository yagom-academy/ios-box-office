//
//  MovieDetails.swift
//  BoxOffice
//
//  Created by Muri, Rowan on 2023/03/21.
//

struct MovieDetails: Decodable {
    let movieInfoResult: MovieInfoResult
}

struct MovieInfoResult: Decodable {
    let movieInfo: MovieInfo
    let source: String
}

struct MovieInfo: Decodable {
    let movieCode, movieName, movieEnglishName, movieOriginalName: String
    let showTime, productionYear, openDate, productionStateName: String
    let typeName: String
    let nations: [Nation]
    let genres: [Genre]
    let directors: [Director]
    let actors: [Actor]
    let showTypes: [ShowType]
    let companies: [Company]
    let audits: [Audit]
    let staff: [Staff]

    enum CodingKeys: String, CodingKey {
        case nations, genres, directors, actors, showTypes, audits
        case movieCode = "movieCd"
        case movieName = "movieNm"
        case movieEnglishName = "movieNmEn"
        case movieOriginalName = "movieNmOg"
        case showTime = "showTm"
        case productionYear = "prdtYear"
        case openDate = "openDt"
        case productionStateName = "prdtStatNm"
        case typeName = "typeNm"
        case companies = "companys"
        case staff = "staffs"
    }
}

struct Actor: Decodable {
    let personName, personEnglishName, castName, castEnglishName: String
    
    enum CodingKeys: String, CodingKey {
        case personName = "peopleNm"
        case personEnglishName = "peopleNmEn"
        case castName = "cast"
        case castEnglishName = "castEn"
    }
}

struct Audit: Decodable {
    let auditNumber, watchGradeName: String
    
    enum CodingKeys: String, CodingKey {
        case auditNumber = "auditNo"
        case watchGradeName = "watchGradeNm"
    }
}

struct Company: Decodable {
    let companyCode, companyName, companyEnglishName, companyPartName: String

    enum CodingKeys: String, CodingKey {
        case companyCode = "companyCd"
        case companyName = "companyNm"
        case companyEnglishName = "companyNmEn"
        case companyPartName = "companyPartNm"
    }
}

struct Director: Decodable {
    let personName, personEnglishName: String
    
    enum CodingKeys: String, CodingKey {
        case personName = "peopleNm"
        case personEnglishName = "peopleNmEn"
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

struct ShowType: Decodable {
    let showTypeGroupName, showTypeName: String
    
    enum CodingKeys: String, CodingKey {
        case showTypeGroupName = "showTypeGroupNm"
        case showTypeName = "showTypeNm"
    }
}

struct Staff: Decodable {
    let personName, personEnglishName, staffRoleName: String
    
    enum CodingKeys: String, CodingKey {
        case personName = "peopleNm"
        case personEnglishName = "peopleNmEn"
        case staffRoleName = "staffRoleNm"
    }
}
