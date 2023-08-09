//
//  Audit.swift
//  BoxOffice
//
//  Created by Zion, Hemg on 2023/07/31.
//

struct Audit: Decodable {
    let auditNo: String
    let watchGradeName: String
    
    private enum CodingKeys: String, CodingKey {
        case auditNo
        case watchGradeName = "watchGradeNm"
    }
}
