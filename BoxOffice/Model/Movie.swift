//
//  Movie.swift
//  BoxOffice
//
//  Created by Morgan, Toy on 11/30/23.
//

import Foundation

struct Movie: Decodable {
    let infomationResult: InfomationResult
    
    private enum CodingKeys: String, CodingKey {
        case infomationResult = "movieInfoResult"
    }
}

extension Movie {
    struct InfomationResult: Decodable {
        let movieInfomation: MovieInfomation
        let source: String
        
        private enum CodingKeys: String, CodingKey {
            case movieInfomation = "movieInfo"
            case source
        }
    }
}

