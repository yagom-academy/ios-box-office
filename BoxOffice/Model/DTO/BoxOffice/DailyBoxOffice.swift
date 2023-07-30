//
//  DailyBoxOffice.swift
//  BoxOffice
//
//  Created by Serena, BMO on 2023/07/24.
//

struct DailyBoxOffice: Decodable {
    let rawNumber: String                       // 순번
    let rank: String                            // 해당 일자 순위
    let rankIntensification: String             // 전일 대비 순위 증감분
    let rankOldAndNew: String                   // 랭킹 신규 진입 여부. "OLD": 기존, "NEW": 신규
    let movieCode: String                       // 영화 대표 코드
    let movieName: String                       // 영화명(국문)
    let openDate: String                        // 개봉일
    let saleAmount: String                      // 해당일 매출액
    let salesShare: String                      // 해당일 상역작 매출총액 대비 해당 영화 매출 비율
    let salesIntensification: String            // 전일 대비 매출액 증감분
    let salesChange: String                     // 전일 대비 매출액 증감 비율
    let salesAccumulation: String               // 누적 매출액
    let audienceCount: String                   // 해당일 관객 수
    let audienceIntensification: String         // 전일 대비 관객수 증감분
    let audienceIntensificationChange: String   // 전일 대비 관객수 증감 비율
    let audienceAccumulation: String            // 누적 관객 수
    let screenCount: String                     // 해당 일자 상영 스크린 수
    let showPlayCount: String                   // 해당 일자 상영 횟수
    
    private enum CodingKeys: String, CodingKey {
        case rawNumber = "rnum"
        case rank
        case rankIntensification = "rankInten"
        case rankOldAndNew
        case movieCode = "movieCd"
        case movieName = "movieNm"
        case openDate = "openDt"
        case saleAmount = "salesAmt"
        case salesShare
        case salesIntensification = "salesInten"
        case salesChange
        case salesAccumulation = "salesAcc"
        case audienceCount = "audiCnt"
        case audienceIntensification = "audiInten"
        case audienceIntensificationChange = "audiChange"
        case audienceAccumulation = "audiAcc"
        case screenCount = "scrnCnt"
        case showPlayCount = "showCnt"
    }
}
