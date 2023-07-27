//
//  MovieResult.swift
//  BoxOffice
//
//  Created by EtialMoon, Minsup on 2023/07/27.
//

struct MovieResult: Decodable {
    let movieInformation: MovieInformation
    let source: String
    
    private enum CodingKeys: String, CodingKey {
        case movieInformation = "movieInfo"
        case source
    }
}
