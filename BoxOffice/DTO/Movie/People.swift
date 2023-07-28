//
//  People.swift
//  BoxOffice
//
//  Created by Serena, BMO on 2023/07/28.
//

struct People: Decodable {
    let peopleName: String
    let peopleEnglishNm: String?
    let cast: String?
    let castEnglish: String?
    let staffRoleName: String?
    
    private enum CodingKeys: String, CodingKey {
        case peopleName = "peopleNm"
        case peopleEnglishNm = "peopleNmEn"
        case cast
        case castEnglish = "castEn"
        case staffRoleName = "staffRoleNm"
    }
}
