//
//  Movie.swift
//  BoxOffice
//
//  Created by redmango, Jusbug on 2023/07/27.
//

struct Movie: Decodable {
    let movieInfoResult: MovieInfoResult
}

struct MovieInfoResult: Decodable {
    let movieInfo: MovieInfo
    let source: String
}

struct MovieInfo: Decodable {
    let movieCode: String
    let movieNm: String
    let movieNmEn: String
    let movieNmOg: String
    let showTime: String
    let prdtYear: String
    let openDate: String
    let prdtStatNm: String
    let typeNm: String
    let nations: [Nations]
    let genres: [Genres]
    let directors: [Directors]
    let actors: [Actors]
    let showTypes: [ShowTypes]
    let companys: [Companys]
    let audits: [Audits]
    let staffs: [Staffs]
    
    private enum CodingKeys: String, CodingKey {
        case movieCode = "movieCd"
        case movieNm
        case movieNmEn
        case movieNmOg
        case showTime = "showTm"
        case prdtYear
        case openDate = "openDt"
        case prdtStatNm
        case typeNm
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

struct Nations: Decodable {
    let nationNm: String
}

struct Genres: Decodable {
    let genreNm: String
}

struct Directors: Decodable {
    let peopleNm: String
    let peopleNmEn: String
}

struct Actors: Decodable {
    let peopleNm: String
    let poepleNmEn: String
    let castNm: String
    let castNmEn: String
    
    private enum CodingKeys: String, CodingKey {
        case peopleNm
        case poepleNmEn
        case castNm = "cast"
        case castNmEn = "castEn"
    }
}

struct ShowTypes: Decodable {
    let showTypeGroupNm: String
    let showTypeNm: String
}

struct Companys: Decodable {
    let companyCd: String
    let companyNm: String
    let companyNmEn: String
    let companyPartNm: String
    
    private enum CodingKeys: String, CodingKey {
        case companyCd = "companyCode"
        case companyNm
        case companyNmEn
        case companyPartNm
    }
}

struct Audits: Decodable {
    let auditNumber: String
    let watchGradeNm: String
    
    private enum CodingKeys: String, CodingKey {
        case auditNumber = "auditNo"
        case watchGradeNm
    }
}

struct Staffs: Decodable {
    let peopleNm: String
    let peopleNmEn: String
    let staffRoleNm: String
}
