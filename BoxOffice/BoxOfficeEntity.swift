//
//  BoxOfficeEntity.swift
//  BoxOffice
//
//  Created by Yetti, Maxhyunm on 2023/07/24.
//

struct BoxOfficeEntity: Decodable {
    struct BoxOfficeResult: Decodable {
        struct DailyBoxOffice: Decodable {
            let resultNumber, rank, rankIntensity, rankOldAndNew, movieCode,
                movieName, openDate, salesAmount, salesShare, salesIntensity,
                salesChange, salesAccumulate, audienceCount, audienceIntensity,
                audienceChange, audienceAccumulate, screenCount, showCount: String
            
            enum CodingKeys: String, CodingKey {
                case rank, rankOldAndNew, salesShare, salesChange
                case resultNumber = "rnum"
                case rankIntensity = "rankInten"
                case movieCode = "movieCd"
                case movieName = "movieNm"
                case openDate = "openDt"
                case salesAmount = "salesAmt"
                case salesIntensity = "salesInten"
                case salesAccumulate = "salesAcc"
                case audienceCount = "audiCnt"
                case audienceIntensity = "audiInten"
                case audienceChange = "audiChange"
                case audienceAccumulate = "audiAcc"
                case screenCount = "scrnCnt"
                case showCount = "showCnt"
            }
        }
        
        enum CodingKeys: String, CodingKey {
            case boxOfficeType = "boxofficeType"
            case showRange, dailyBoxOfficeList
        }
        
        let boxOfficeType, showRange: String
        let dailyBoxOfficeList: [DailyBoxOffice]
    }
    
    let boxOfficeResult: BoxOfficeResult
}


