//
//  Nation.swift
//  BoxOffice
//
//  Created by Serena, BMO on 2023/07/28.
//

struct Nation: Decodable {
    let nationName: String // 국가 이름
    
    private enum CodingKeys: String, CodingKey {
        case nationName = "nationNm"
    }
}
