//
//  Movie.swift
//  BoxOffice
//
//  Created by Christy, Hyemory on 2023/03/22.
//

import Foundation

struct Movie: Codable {
    let result: Result
    
    private enum CodingKeys: String, CodingKey {
        case result = "movieInfoResult"
    }
    
    struct Result: Codable {
        let movieInfo: MovieInfo
        let source: String
    }
}
