//
//  MovieDetailInformationResult.swift
//  BoxOffice
//
//  Created by Idinaloq, MARY on 2023/07/26.
//

struct MovieDetailInformationResult: Decodable {
    let movieInformation: MovieDetailInformation
    let source: String
    
    enum CodingKeys: String, CodingKey {
        case movieInformation = "MovieInfo"
        case source
    }
    
}
