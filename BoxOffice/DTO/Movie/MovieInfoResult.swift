//
//  MovieInfoResult.swift
//  BoxOffice
//
//  Created by Serena, BMO on 2023/07/28.
//

struct MovieInfoResult: Decodable {
    let movieInformation: MovieInfo
    let source: String
    
    private enum CodingKeys: String, CodingKey {
        case movieInformation = "movieInfo"
        case source
    }
}
