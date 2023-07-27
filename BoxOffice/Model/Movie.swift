//
//  Movie.swift
//  BoxOffice
//
//  Created by redmango, Jusbug on 2023/07/27.
//

struct Movie: Decodable {
    let movieInfoResult: movieInfoResult
}

struct movieInfoResult: Decodable {
    let movieInfo: MovieInfo
    let source: String
}

struct MovieInfo: Decodable {
    let movieCd: String
    let movieNm: String
    let movieNmEn: String
    let movieNmOg: String
    let showTm: String
    let prdtYear: String
    let openDt: String
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
    let peopleNmEn: String
    let cast: String
    let castEn: String
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
}

struct Audits: Decodable {
    let auditNo: String
    let watchGradeNm: String
}

struct Staffs: Decodable {
    let peopleNm: String
    let peopleNmEn: String
    let staffRoleNm: String
}
