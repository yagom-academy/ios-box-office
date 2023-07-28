//
//  BoxOfficeAPI.swift
//  BoxOfficeTests
//
//  Created by Zion on 2023/07/28.
//

import Foundation

enum BoxOfficeAPI {
    case daily
    case movieDetailInformation
    
    var sampleData: Data {
        switch self {
        case .daily:
            return Data()
        case .movieDetailInformation:
            return Data()
        }
    }
}
