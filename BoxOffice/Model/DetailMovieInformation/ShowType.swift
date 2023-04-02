//
//  ShowType.swift
//  BoxOffice
//
//  Created by Rhode, Rilla on 2023/03/21.
//

struct ShowType: Decodable, StringConvertible {
    var description: String { return showTypeName }
    let showTypeGroupName: String
    let showTypeName: String
        
    private enum CodingKeys: String, CodingKey {
        case showTypeGroupName = "showTypeGroupNm"
        case showTypeName = "showTypeNm"
    }
}
