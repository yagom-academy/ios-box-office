//
//  MovieInfo.swift
//  BoxOffice
//
//  Created by 레옹아범 ,Andrew on 2023/03/20.
//

import Foundation

struct DailyBoxOffice {
    let boxOfficeResult: BoxOfficeResult
}

struct BoxOfficeResult {
    let boxofficeType: String
    let showRange: String
    let dailyBoxOfficeList: [MovieInfo]
}

struct MovieInfo {
    let rnum, rank, rankInten, rankOldAndNew: String
    let movieCd, movieNm: String
    let openDt: String
    let salesAmt, salesShare, salesInten, salesChange, salesAcc: String
    let audiCnt, audiInten, audiChange, audiAcc: String
    let scrnCnt: String
    let showCnt: String
}
