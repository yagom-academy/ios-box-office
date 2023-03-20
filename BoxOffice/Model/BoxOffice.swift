//
//  BoxOffice.swift
//  BoxOffice
//
//  Created by 리지, kokkilE on 2023/03/20.
//

struct BoxOffice: Decodable {
    let boxOfficeResult: BoxOfficeResult
    
    struct BoxOfficeResult: Decodable {
        let boxOfficeType: String
        let showRange: String
        let boxOfficeList: [Movie]
        
        enum CodingKeys: String, CodingKey {
            case showRange
            case boxOfficeType = "boxofficeType"
            case boxOfficeList = "dailyBoxOfficeList"
        }
        
        struct Movie: Decodable {
            let order: String
            let rank: String
            let rankVariance: String
            let rankOldAndNew: String
            let code: String
            let name: String
            let openDate: String
            let salesAmount: String
            let salesShare: String
            let salesVariance: String
            let salesChange: String
            let salesAccumulation: String
            let audienceCount: String
            let audienceVariance: String
            let audienceChange: String
            let audienceAccumulation: String
            let screenCount: String
            let showCount: String
            
            enum CodingKeys: String, CodingKey {
                case rank, rankOldAndNew, salesShare, salesChange
                case order = "rnum"
                case rankVariance = "rankInten"
                case code = "movieCd"
                case name = "movieNm"
                case openDate = "openDt"
                case salesAmount = "salesAmt"
                case salesVariance = "salesInten"
                case salesAccumulation = "salesAcc"
                case audienceCount = "audiCnt"
                case audienceVariance = "audiInten"
                case audienceChange = "audiChange"
                case audienceAccumulation = "audiAcc"
                case screenCount = "scrnCnt"
                case showCount = "showCnt"
            }
        }
    }
}
