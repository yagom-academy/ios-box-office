//
//  MovieInformationResult.swift
//  BoxOffice
//
//  Created by Rhode, Rilla on 2023/03/21.
//

struct MovieInformationResult: Decodable {
    let movieInformation: MovieInformation
    let source: String
    
    private enum CodingKeys: String, CodingKey {
        case movieInformation = "movieInfo"
        case source
    }
}
