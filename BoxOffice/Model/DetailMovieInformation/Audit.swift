//
//  Audit.swift
//  BoxOffice
//
//  Created by Rhode, Rilla on 2023/03/21.
//

struct Audit: Decodable {
    let auditNumber: String
    let watchGradeName: String
        
    private enum CodingKeys: String, CodingKey {
        case auditNumber = "auditNo"
        case watchGradeName = "watchGradeNm"
    }
}
