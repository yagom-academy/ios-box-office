//
//  Nation.swift
//  BoxOffice
//
//  Created by Zion, Hemg on 2023/07/31.
//

struct Nation: Decodable {
    let nationName: String
    
    private enum CodingKeys: String, CodingKey {
        case nationName = "nationNm"
    }
}
