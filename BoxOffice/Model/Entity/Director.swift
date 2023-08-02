//
//  Director.swift
//  BoxOffice
//
//  Created by Zion, Hemg on 2023/07/31.
//

struct Director: Decodable {
    let peopleName: String
    let peopleNameEnglish: String
    
    private enum CodingKeys: String, CodingKey {
        case peopleName = "peopleNm"
        case peopleNameEnglish = "peopleNmEn"
    }
}
