//
//  BoxofficeResultObject.swift
//  BoxOffice
//
//  Created by 레옹아범 ,Andrew on 2023/03/20.
//

struct BoxofficeResultObject: Decodable {
    let movies: [InfoObject]
    
    private enum CodingKeys: String, CodingKey {
        case movies = "dailyBoxOfficeList"
    }
}
