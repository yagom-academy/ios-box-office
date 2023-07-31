//
//  MovieInfo.swift
//  BoxOffice
//
//  Created by Serena, BMO on 2023/07/28.
//

struct MovieInfo: Decodable {
    let movieCode: String               // 영화코드
    let movieName: String               // 영화 국문 이름
    let movieEnglishName: String        // 영화 영문 이름
    let movieOriginalName: String       // 영화 원문 이름
    let showTime: String                // 상영시간
    let productionYear: String          // 제작 연도
    let openDate: String                // 개봉 연도
    let productionStatusName: String    // 제작상태 이름
    let typeName: String                // 영화 유형 이름
    let nations: [Nation]               // 제작 국가
    let genres: [Genre]                 // 장르 이름
    let directors: [People]             // 감독
    let actors: [People]                // 배우
    let showTypes: [ShowType]           // 상영 형태
    let companys: [Company]             // 참여 영화사
    let audits: [Audit]                 // 심의 정보
    let staffs: [People]                // 스텝
    
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
