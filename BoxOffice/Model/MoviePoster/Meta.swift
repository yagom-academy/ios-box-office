//
//  Meta.swift
//  BoxOffice
//
//  Created by Rhode, Rilla on 2023/04/01.
//

import Foundation

struct Meta: Decodable {
    let isEnd: Bool
    let pageableCount: Int
    let totalCount: Int

    enum CodingKeys: String, CodingKey {
        case isEnd = "is_end"
        case pageableCount = "pageable_count"
        case totalCount = "total_count"
    }
}
