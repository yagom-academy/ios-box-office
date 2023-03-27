//
//  DailyBoxOffice.swift
//  BoxOffice
//
//  Created by kaki, Harry on 2023/03/27.
//

struct DailyBoxOffice: Decodable {
    let rankText: String
    let rankIncrementText: String
    let rankOldAndNew: RankOldAndNew
    let movieCodeText: String
    let movieKoreanName: String
    let audienceCountText: String
    let audienceAccumulationText: String
    
    enum CodingKeys: String, CodingKey {
        case rankText = "rank"
        case rankOldAndNew
        case rankIncrementText = "rankInten"
        case movieCodeText = "movieCd"
        case movieKoreanName = "movieNm"
        case audienceCountText = "audiCnt"
        case audienceAccumulationText = "audiAcc"
    }
}
