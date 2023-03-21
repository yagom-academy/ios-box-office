//
//  BoxofficeResultObject.swift
//  BoxOffice
//
//  Created by 레옹아범 ,Andrew on 2023/03/20.
//

struct BoxofficeResultObject: Decodable {
    let boxofficeType: String
    let dateRange: String
    let movies: [InfoObject]
    
    enum CodingKeys: String, CodingKey {
        case boxofficeType
        case dateRange = "showRange"
        case movies = "dailyBoxOfficeList"
    }
}
