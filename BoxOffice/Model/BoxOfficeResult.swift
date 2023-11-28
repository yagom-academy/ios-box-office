//
//  File.swift
//  BoxOffice
//
//  Created by Hisop on 2023/11/27.
//

struct BoxOffice: Decodable {
    private let boxOfficeResult: BoxOfficeResult
}

struct BoxOfficeResult: Decodable {
    private let boxofficeType: String
    private let showRange: String
    private let dailyBoxOfficeList: [DailyBoxOffice]
}

struct DailyBoxOffice: Decodable {
    private let rankNumber: String
    private let rank: String
    private let rankIntensity: String
    private let rankOldAndNew: String
    private let movieCode: String
    private let movieName: String
    private let openDate: String
    private let salesAmount: String
    private let salesShare: String
    private let salesIntensity: String
    private let salesChange: String
    private let salesAccumulated: String
    private let audienceCount: String
    private let audienceIntensity: String
    private let audienceChange: String
    private let audienceAccumulated: String
    private let screenCount: String
    private let showCount: String
    
    enum CodingKeys: String, CodingKey {
        case rankNumber = "rnum"
        case rank
        case rankIntensity = "rankInten"
        case rankOldAndNew
        case movieCode = "movieCd"
        case movieName = "movieNm"
        case openDate = "openDt"
        case salesAmount = "salesAmt"
        case salesShare
        case salesIntensity = "salesInten"
        case salesChange
        case salesAccumulated = "salesAcc"
        case audienceCount = "audiCnt"
        case audienceIntensity = "audiInten"
        case audienceChange = "audiChange"
        case audienceAccumulated = "audiAcc"
        case screenCount = "scrnCnt"
        case showCount = "showCnt"
    }
}
