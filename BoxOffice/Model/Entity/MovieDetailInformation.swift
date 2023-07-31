//
//  MovieDetailInformation.swift
//  BoxOffice
//
//  Created by Zion, Hemg on 2023/07/27.
//

struct MovieDetailResult: Decodable {
    let movieInformationResult: MovieDetailInformation
    
    private enum CodingKeys: String, CodingKey {
        case movieInformationResult = "movieInfoResult"
    }
    
    struct MovieDetailInformation: Decodable {
        let movieInformation: MovieDetail
        let source: String
        
        private enum CodingKeys: String, CodingKey {
            case movieInformation = "movieInfo"
            case source
        }
    }
}
