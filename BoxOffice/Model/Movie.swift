//
//  Movie.swift
//  BoxOffice
//
//  Created by Dasan & Whales on 2023/07/27.
//

struct Movie: Decodable {
    let movieInformationResult: MovieInformationResult
    
    private enum CodingKeys: String, CodingKey {
        case movieInformationResult = "movieInfoResult"
    }
}

struct MovieInformationResult: Decodable {
    let movieInformation: MovieInformation
    let source: String
    
    private enum CodingKeys: String, CodingKey {
        case movieInformation = "movieInfo"
        case source
    }
}

struct MovieInformation: Decodable {
    let movieCode: String
    let movieName: String
    let movieEnglishName: String
    let movieOriginalName: String
    let showTime: String
    let productionYear: String
    let openingDate: String
    let productionStatusName: String
    let typeName: String
    let nations: [Nation]
    let genres: [Genre]
    let directors: [Director]
    let actors: [Actor]
    let showTypes: [ShowType]
    let companies: [Company]
    let audits: [Audit]
    let staffs: [Staff]
    
    private enum CodingKeys: String, CodingKey {
        case movieCode = "movieCd"
        case movieName = "movieNm"
        case movieEnglishName = "movieNmEn"
        case movieOriginalName = "movieNmOg"
        case showTime = "showTm"
        case productionYear = "prdtYear"
        case openingDate = "openDt"
        case productionStatusName = "prdtStatNm"
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
    let personName: String
    let personEnglishName: String

    private enum CodingKeys: String, CodingKey {
        case personName = "peopleNm"
        case personEnglishName = "peopleNmEn"
    }
}

struct Actor: Decodable {
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
