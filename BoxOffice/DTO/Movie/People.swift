//
//  People.swift
//  BoxOffice
//
//  Created by Hyun A Song on 2023/07/28.
//

struct People: Decodable {
    let peopleNm: String
    let peopleNmEn: String?
    let cast: String?
    let castEn: String?
    let staffRoleNm: String?
}
