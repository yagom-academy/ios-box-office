//
//  BoxOfficeAPI.swift
//  BoxOfficeTests
//
//  Created by Zion on 2023/07/28.
//

import UIKit

enum BoxOfficeAPI {
    case daily
    case movieDetailInformation
    
    var sampleData: Data {
        switch self {
        case .daily:
            return (NSDataAsset(name: "Daily")?.data)!
        case .movieDetailInformation:
            return (NSDataAsset(name: "MovieDetailInfromation")?.data)!
        }
    }
}
