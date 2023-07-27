//
//  Movie.swift
//  BoxOffice
//
//  Created by EtialMoon, Minsup on 2023/07/27.
//

struct Movie: Decodable {
    let movieResult: MovieResult
    
    private enum CodingKeys: String, CodingKey {
        case movieResult = "movieInfoResult"
    }
}
