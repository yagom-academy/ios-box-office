//
//  Extension.swift
//  BoxOffice
//
//  Created by Hisop on 2023/11/28.
//
import Foundation

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
