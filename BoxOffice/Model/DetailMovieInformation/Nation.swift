//
//  Nation.swift
//  BoxOffice
//
//  Created by Rhode, Rilla on 2023/03/21.
//

struct Nation: Decodable {
    let nationName: String
        
    private enum CodingKeys: String, CodingKey {
        case nationName = "nationNm"
    }
}
