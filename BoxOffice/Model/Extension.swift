//
//  Extension.swift
//  BoxOffice
//
//  Created by Hisop on 2023/11/28.
//

extension BoxOffice: Equatable {
    static func == (lhs: BoxOffice, rhs: BoxOffice) -> Bool {
        return lhs.boxOfficeResult == rhs.boxOfficeResult
    }
}

extension BoxOfficeResult: Equatable {
    static func == (lhs: BoxOfficeResult, rhs: BoxOfficeResult) -> Bool {
        for (index, dailyBoxOffice) in lhs.dailyBoxOfficeList.enumerated() {
            guard dailyBoxOffice == rhs.dailyBoxOfficeList[index] else {
                return false
            }
        }
        guard lhs.boxofficeType == rhs.boxofficeType &&
                lhs.showRange == rhs.showRange else {
            return false
        }
        return true
    }
}

extension DailyBoxOffice: Equatable {
    static func == (lhs: DailyBoxOffice, rhs: DailyBoxOffice) -> Bool {
        return lhs.rankNumber == rhs.rankNumber &&
        lhs.rank == rhs.rank &&
        lhs.rankIntensity == rhs.rankIntensity &&
        lhs.rankOldAndNew == rhs.rankOldAndNew &&
        lhs.movieCode == rhs.movieCode &&
        lhs.movieName == rhs.movieName &&
        lhs.openDate == rhs.openDate &&
        lhs.salesAmount == rhs.salesAmount &&
        lhs.salesShare == rhs.salesShare &&
        lhs.salesIntensity == rhs.salesIntensity &&
        lhs.salesChange == rhs.salesChange &&
        lhs.salesAccumulated == rhs.salesAccumulated &&
        lhs.audienceCount == rhs.audienceCount &&
        lhs.audienceIntensity == rhs.audienceIntensity &&
        lhs.audienceChange == rhs.audienceChange &&
        lhs.audienceAccumulated == rhs.audienceAccumulated &&
        lhs.screenCount == rhs.screenCount &&
        lhs.showCount == rhs.showCount
    }
}
