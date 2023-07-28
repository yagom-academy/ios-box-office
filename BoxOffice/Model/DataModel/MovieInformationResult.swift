//
//  MovieInformationResult.swift
//  BoxOffice
//
//  Created by Idinaloq, MARY on 2023/07/26.
//

struct MovieInformationResult: Decodable {
    let movieInformation: MovieInformation
    let source: String
    
    enum CodingKeys: String, CodingKey {
        case movieInformation = "movieInfo"
        case source
    }
    
}
