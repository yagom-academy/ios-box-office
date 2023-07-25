//
//  BoxOfficeResult.swift
//  BoxOffice
//
//  Created by Serena, BMO on 2023/07/24.
//

struct BoxOfficeResult: Decodable {
    let boxOfficeType: String                   // 박스오피스 종류
    let showRange: String                       // 조회 일자 범위
    let dailyBoxOfficeList: [DailyBoxOffice]    // 일별 박스오피스 목록
    
    private enum CodingKeys: String, CodingKey {
        case boxOfficeType = "boxofficeType"
        case showRange
        case dailyBoxOfficeList
    }
}
