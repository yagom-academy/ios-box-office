//
//  BoxOffice.swift
//  BoxOffice
//
//  Created by Kobe, yyss99 on 2023/07/25.
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
	let rankNumber: String
	let rank: String
	let rankIntensity: String
	let rankOldAndNew: String
	let movieCode: String
	let movieNumber: String
	let openDate: String
	let salesAmount: String
	let salesShare: String
	let salesIntensity: String
	let salesChange: String
	let salesAccumulated: String
	let audienceCount: String
	let audienceIntensity: String
	let audienceChange: String
	let audienceAccumulated: String
	let screenCount: String
	let showCount: String
    
    private enum CodingKeys: String, CodingKey {
        case rankNumber = "rnum"
        case rank
        case rankIntensity = "rankInten"
        case rankOldAndNew
        case movieCode = "movieCd"
        case movieNumber = "movieNm"
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
