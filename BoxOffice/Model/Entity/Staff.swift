//
//  Staff.swift
//  BoxOffice
//
//  Created by Zion, Hemg on 2023/07/31.
//

struct Staff: Decodable {
    let peopleName: String
    let peopleNameEnglish: String
    let staffRoleName: String
    
    private enum CodingKeys: String, CodingKey {
        case peopleName = "peopleNm"
        case peopleNameEnglish = "peopleNmEn"
        case staffRoleName = "staffRoleNm"
    }
}
