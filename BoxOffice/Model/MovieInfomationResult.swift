//
//  MovieInfomationResult.swift
//  BoxOffice
//
//  Created by Morgan, Toy on 11/30/23.
//

import Foundation

struct Movie: Decodable {
    let movieDetailResult: InfomationResult
    
    private enum CodingKeys: String, CodingKey {
        case movieDetailResult = "movieInfoResult"
    }
}

extension Movie {
    struct InfomationResult: Decodable {
        let movieDetail: Infomation
        let source: String
        
        private enum CodingKeys: String, CodingKey {
            case movieDetail = "movieInfo"
            case source
        }
    }
}

