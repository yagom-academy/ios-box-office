//
//  ShowType.swift
//  BoxOffice
//
//  Created by Serena, BMO on 2023/07/28.
//

struct ShowType: Decodable {
    let showTypeGroupName: String   // 상영 형태 구분
    let showTypeName: String        // 상영 형태 이름
    
    private enum CodingKeys: String, CodingKey {
        case showTypeGroupName = "showTypeGroupNm"
        case showTypeName = "showTypeNm"
    }
}
