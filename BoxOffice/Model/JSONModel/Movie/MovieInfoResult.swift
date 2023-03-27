//
//  MovieInfoResult.swift
//  BoxOffice
//
//  Created by kaki, harry on 2023/03/27.
//

struct MovieInfoResult: Decodable {
    let info: MovieInfo
    let source: String
    
    enum CodingKeys: String, CodingKey {
        case info = "movieInfo"
        case source
    }
}
