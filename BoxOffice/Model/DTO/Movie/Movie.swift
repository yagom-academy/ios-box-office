//
//  Movie.swift
//  BoxOffice
//
//  Created by Serena, BMO on 2023/07/28.
//

struct Movie: Decodable {
    let movieInformationResult: MovieInfoResult
    
    private enum CodingKeys: String, CodingKey {
        case movieInformationResult = "movieInfoResult"
    }
}
