//
//  MovingInfo.swift
//  BoxOffice
//
//  Created by 박종화 on 2023/07/24.
//

import Foundation

struct MovieInfo: Decodable {
    let rnum: Int
    let rank: Int
    let rankInten: Int
    let rankOldAndNew: String
    let movieCd: Int
    let movieNm: String
    let openDt: String
    let salesAmt: Int
    let salseShare: Double
    let salesInten: Int
    let salesChange: Double
    let saelsAcc: Int
    let audiCnt: Int
    let audiInten: Int
    let audiChange: Int
    let audiAcc: Int
    let scrnCnt: Int
    let showCnt: Int
    
    private enum CodingKeys: String, CodingKey {
        case rankNumber = "rnum"
        case movieCode = "movieCd"
        case movieName = "movieNm"
        case openDate = "openDt"
    }
}
