//
//  MovieDetailInformationDTO.swift
//  BoxOffice
//
//  Created by vetto, brody on 23/03/21.
//

struct MovieDetailInformation: Decodable {
    let movieCode: String
    let movieName: String
    let movieEnglishName: String
    let movieOriginalName: String
    let showingTime: String
    let productYear: String
    let openDate: String
    let productStateName: String
    let typeName: String
    let nations: [Nation]
    let genres: [Genre]
    let directors: [Director]
    let actors: [Actor]
    let showTypes: [ShowType]
    let companies: [Company]
    let audits: [Audit]
    let staffs: [Staff]

    enum CodingKeys: String, CodingKey {
        case movieCode = "movieCd"
        case movieName = "movieNm"
        case movieEnglishName = "movieNmEn"
        case movieOriginalName = "movieNmOg"
        case showingTime = "showTm"
        case productYear = "prdtYear"
        case openDate = "openDt"
        case productStateName = "prdtStatNm"
        case typeName = "typeNm"
        case nations
        case genres
        case directors
        case actors
        case showTypes
        case companies = "companys"
        case audits
        case staffs
    }
}

// MARK: - Actor
struct Actor: Decodable {
    let personName: String
    let personEnglishName: String
    let cast: String
    let castEnglish: String
    
    enum CodingKeys: String, CodingKey {
        case personName = "peopleNm"
        case personEnglishName = "peopleNmEn"
        case cast
        case castEnglish = "castEn"
    }
}

// MARK: - Audit
struct Audit: Decodable {
    let auditNumber: String
    let watchGradeName: String
    
    enum CodingKeys: String, CodingKey {
        case auditNumber = "auditNo"
        case watchGradeName = "watchGradeNm"
    }
}

// MARK: - Company
struct Company: Decodable {
    let companyCode: String
    let companyName: String
    let companyEnglishName: String
    let companyPartName: String

    enum CodingKeys: String, CodingKey {
        case companyCode = "companyCd"
        case companyName = "companyNm"
        case companyEnglishName = "companyNmEn"
        case companyPartName = "companyPartNm"
    }
}

// MARK: - Director
struct Director: Decodable {
    let personName: String
    let personEnglishName: String
    
    enum CodingKeys: String, CodingKey {
        case personName = "peopleNm"
        case personEnglishName = "peopleNmEn"
    }
}

// MARK: - Genre
struct Genre: Decodable {
    let genreName: String
    
    enum CodingKeys: String, CodingKey {
        case genreName = "genreNm"
    }
}

// MARK: - Nation
struct Nation: Decodable {
    let nationName: String
    
    enum CodingKeys: String, CodingKey {
        case nationName = "nationNm"
    }
}

// MARK: - ShowType
struct ShowType: Decodable {
    let showingTypeGroupName: String
    let showingTypeName: String
    
    enum CodingKeys: String, CodingKey {
        case showingTypeGroupName = "showTypeGroupNm"
        case showingTypeName = "showTypeNm"
    }
}

// MARK: - Staff
struct Staff: Decodable {
    let personName: String
    let personEnglishName: String
    let staffRoleName: String
    
    enum CodingKeys: String, CodingKey {
        case personName = "peopleNm"
        case personEnglishName = "peopleNmEn"
        case staffRoleName = "staffRoleNm"
    }
}
