//
//  ShowType.swift
//  BoxOffice
//
//  Created by Zion, Hemg on 2023/07/31.
//

struct ShowType: Decodable {
    let showTypeGroupName: String
    let showTypeName: String
    
    private enum CodingKeys: String, CodingKey {
        case showTypeGroupName = "showTypeGroupNm"
        case showTypeName = "showTypeNm"
    }
}
