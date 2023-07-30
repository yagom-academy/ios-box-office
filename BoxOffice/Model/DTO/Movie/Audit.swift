//
//  Audit.swift
//  BoxOffice
//
//  Created by Serena, BMO on 2023/07/28.
//

struct Audit: Decodable {
    let auditNumber: String     // 심의 번호
    let watchGradeName: String  // 관람 등급 이름
    
    private enum CodingKeys: String, CodingKey {
        case auditNumber = "auditNo"
        case watchGradeName = "watchGradeNm"
    }
}
