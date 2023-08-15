//
//  BoxOfficeData.swift
//  BoxOffice
//
//  Created by 훈민트 on 2023/07/25.
//

struct BoxOfficeData: Decodable {
    let boxOfficeResult: BoxOfficeResult
}

struct BoxOfficeResult: Decodable {
    let boxOfficeType: BoxOfficeType
    let Duration: String
    let dailyBoxOfficeList: [BoxOfficeItem]
    
    enum BoxOfficeType: String, Decodable {
        case dailyBoxOffice = "일별 박스오피스"
        case weeklyBoxOffice = "주간/주말 박스오피스"
    }
    
    private enum CodingKeys: String, CodingKey {
        case boxOfficeType = "boxofficeType"
        case Duration = "showRange"
        case dailyBoxOfficeList
    }
}

struct BoxOfficeItem: Decodable, Equatable {
    let number: String
    let rank: String
    let rankVariation: String
    let rankExistence: RankExistence
    let movieCode: String
    let movieName: String
    let openDate: String
    let salesAmount: String
    let salesShare: String
    let salesVariation: String
    let salesChange: String
    let salesAccumulate: String
    let audienceCount: String
    let audienceVariation: String
    let audienceChange: String
    let audienceAccumulate: String
    let screenCount: String
    let showCount: String
    
    enum RankExistence: String, Decodable {
        case old = "OLD"
        case new = "NEW"
    }
    
    private enum CodingKeys: String, CodingKey {
        case number = "rnum"
        case rank
        case rankVariation = "rankInten"
        case rankExistence = "rankOldAndNew"
        case movieCode = "movieCd"
        case movieName = "movieNm"
        case openDate = "openDt"
        case salesAmount = "salesAmt"
        case salesShare
        case salesVariation = "salesInten"
        case salesChange
        case salesAccumulate = "salesAcc"
        case audienceCount = "audiCnt"
        case audienceVariation = "audiInten"
        case audienceChange = "audiChange"
        case audienceAccumulate = "audiAcc"
        case screenCount = "scrnCnt"
        case showCount = "showCnt"
    }
}
