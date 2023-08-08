//
//  DetailInformation.swift
//  BoxOffice
//
//  Created by Idinaloq, MARY on 2023/07/26.
//

struct DetailInformation: Decodable {
    let movieInformationResult: MovieInformationResult
    
    enum CodingKeys: String, CodingKey {
        case movieInformationResult = "movieInfoResult"
    }
}
