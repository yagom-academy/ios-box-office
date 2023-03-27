//
//  Actor.swift
//  BoxOffice
//
//  Created by kaki, harry on 2023/03/27.
//

struct Actor: Decodable {
    let peopleName: String
    
    enum CodingKeys: String, CodingKey {
        case peopleName = "peopleNm"
    }
}
