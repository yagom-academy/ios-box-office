//
//  Nation.swift
//  BoxOffice
//
//  Created by kaki, harry on 2023/03/27.
//

struct Nation: Decodable {
    let nationName: String
    
    enum CodingKeys: String, CodingKey {
        case nationName = "nationNm"
    }
}
