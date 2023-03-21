//
//  Actor.swift
//  BoxOffice
//
//  Created by Rhode, Rilla on 2023/03/21.
//

struct Actor: Decodable {
    let peopleName: String
    let peopleNameEnglish: String
    let cast: String
    let castEnglish: String
        
    private enum CodingKeys: String, CodingKey {
        case peopleName = "peopleNm"
        case peopleNameEnglish = "peopleNmEn"
        case cast
        case castEnglish = "castEn"
    }
}
