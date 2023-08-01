//
//  BoxOffice.swift
//  BoxOffice
//
//  Created by kyungmin, Erick on 2023/07/24.
//

struct BoxOffice: Decodable {
    let boxOfficeResult: BoxOfficeResult
}

struct BoxOfficeResult: Decodable {
    let boxOfficeType: String
    let showRange: String
    let dailyBoxOfficeList: [DailyBoxOfficeList]
    
    private enum CodingKeys: String, CodingKey {
        case boxOfficeType = "boxofficeType"
        case showRange
        case dailyBoxOfficeList
    }
}

struct DailyBoxOfficeList: Decodable {
    let number: String
    let rank: String
    let rankIntensity: String
    let rankOldAndNew: String
    let movieCode: String
    let movieName: String
    let openDate: String
    let salesAmount: String
    let salesShare: String
    let salseIntensity: String
    let salesChange: String
    let salesAccumulation: String
    let audienceCount: String
    let audienceIntensity: String
    let audienceChange: String
    let audienceAccumulation: String
    let screenCount: String
    let showCount: String
    
    private enum CodingKeys: String, CodingKey {
        case number = "rnum"
        case rank
        case rankIntensity = "rankInten"
        case rankOldAndNew
        case movieCode = "movieCd"
        case movieName = "movieNm"
        case openDate = "openDt"
        case salesAmount = "salesAmt"
        case salesShare
        case salseIntensity = "salesInten"
        case salesChange
        case salesAccumulation = "salesAcc"
        case audienceCount = "audiCnt"
        case audienceIntensity = "audiInten"
        case audienceChange = "audiChange"
        case audienceAccumulation = "audiAcc"
        case screenCount = "scrnCnt"
        case showCount = "showCnt"
    }
}

// MARK: Make DTO
extension DailyBoxOfficeList {
    func makedDailyBoxOfficeData() -> DailyBoxOfficeData? {
        guard let decimalAudienceCount = FormatManager.bringDecimalString(audienceCount),
              let decimalaudienceAccumulation = FormatManager.bringDecimalString(audienceAccumulation) else {
            return nil
        }
        
        let dailyAndTotalAudience = "오늘 \(decimalAudienceCount) / 총 \(decimalaudienceAccumulation)"
        var rankState = ""
        
        if rankOldAndNew == "NEW" {
            rankState = "신작"
        } else if rankIntensity == "0" {
            rankState = "0"
        } else if rankIntensity.contains("-") {
            var rankIntensity = rankIntensity
            rankIntensity.removeFirst()
            rankState = "▼" + rankIntensity
        } else {
            rankState = "▲" + rankIntensity
        }
        
        return DailyBoxOfficeData(rank: rank, rankState: rankState, movieTitle: movieName, dailyAndTotalAudience: dailyAndTotalAudience)
    }
}
