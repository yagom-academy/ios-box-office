//
//  MovieInformation.swift
//  BoxOffice
//
//  Created by vetto, brody on 23/03/21.
//

import Foundation

struct MovieInformation: Decodable {
    let movieInfoResult: MovieInformationResult
    
    struct MovieInformationResult: Decodable {
        let movieInformation: MovieDetailInformation
        let source: String
        
        enum CodingKeys: String, CodingKey {
            case movieInformation = "movieInfo"
            case source
        }
    }
}

