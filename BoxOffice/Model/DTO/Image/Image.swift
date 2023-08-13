//
//  Image.swift
//  BoxOffice
//
//  Created by EtialMoon, Minsup on 2023/08/08.
//

struct Image: Decodable {
    let meta: Meta
    let imageDocuments: [ImageDocument]
    
    private enum CodingKeys: String, CodingKey {
        case meta
        case imageDocuments = "documents"
    }
}

struct Meta: Decodable {
    let totalCount: Int
    let pageableCount: Int
    let isEnd: Bool
    
    private enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case pageableCount = "pageable_count"
        case isEnd = "is_end"
    }
}
