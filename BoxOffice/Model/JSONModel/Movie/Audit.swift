//
//  Audit.swift
//  BoxOffice
//
//  Created by kaki, harry on 2023/03/27.
//

struct Audit: Decodable {
    let watchGradeName: String
    
    enum CodingKeys: String, CodingKey {
        case watchGradeName = "watchGradeNm"
    }
}
