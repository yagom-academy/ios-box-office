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
    let movieCd: String
    let movieNm: String
    let movieNmEn: String
    let movieNmOg: String
    let showTm: String
    let prdtYear: String
    let openDt: String
    let prdtStatNm: String
    let typeNm: String
    let nations: [Nation]
    let genres: [Genre]
    let directors: [Director]
    let actors: [Actor]
    let showType: [ShowType]
    let companys: [Company]
    let audits: [Audit]
    let staffs: [Staff]
    let source: String
}

struct Nation: Decodable {
    let nationNm: String
}

struct Genre: Decodable {
    let genreNm: String
}

struct Director: Decodable {
    let peopleNm: String
    let peopleNmEn: String
}

struct Actor: Decodable {
    let peopleNm: String
    let peopleNmEn: String
    let cast: String
    let caseEn: String
}

struct ShowType: Decodable {
    let showTypeGroupNm: String
    let showTypeNm: String
}

struct Company: Decodable {
    let companyCd: String
    let companyNm: String
    let companyNmEn: String
    let companyPartNm: String
}

struct Audit: Decodable {
    let auditNo: String
    let watchGradeNm: String
}

struct Staff: Decodable {
    let peopleNm: String
    let peopleNmEn: String
    let staffRoleNm: String
}

