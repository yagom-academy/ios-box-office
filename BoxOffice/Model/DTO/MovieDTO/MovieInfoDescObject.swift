//
//  MovieInfoDescObject.swift
//  BoxOffice
//
//  Created by Andrew, 레옹아범 on 2023/03/21.
//

import Foundation

struct MovieInfoDescObject: Decodable {
    let name: String
    let englishName: String
    let time: String
    let productedYear: String
    let status: String
    let type: String
    
    enum CodingKeys: String, CodingKey {
        case name = "movieNm"
        case englishName = "movieNmEn"
        case time = "showTm"
        case productedYear = "prdtYear"
        case status = "prdtStatNm"
        case type = "typeNm"
    }
}
