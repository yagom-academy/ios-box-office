//
//  MovieInfo.swift
//  BoxOffice
//
//  Created by Serena, BMO on 2023/07/28.
//

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
    let nations: [Nation]
    let genres: [Genre]
    let directors: [People]
    let actors: [People]
    let showTypes: [ShowType]
    let companys: [Company]
    let audits: [Audit]
    let staffs: [People]
}
