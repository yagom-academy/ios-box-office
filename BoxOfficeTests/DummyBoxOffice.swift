//
//  DummyBoxOffice.swift
//  BoxOfficeTests
//
//  Created by Christy, Hyemory on 2023/03/23.
//

import Foundation

struct DummyBoxOffice: Codable {
    let result: DummyResult
    
    private enum CodingKeys: String, CodingKey {
        case result = "boxOfficeResult"
    }
    
    struct DummyResult: Codable {
        let type: Int
        let showRange: Int
        let dailyBoxOfficeList: [Int]
        
        private enum CodingKeys: String, CodingKey {
            case type = "boxofficeType"
            case showRange, dailyBoxOfficeList
        }
    }
} 
