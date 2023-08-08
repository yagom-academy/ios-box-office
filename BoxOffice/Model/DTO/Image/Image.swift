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
    let total_count: Int
    let pageable_count: Int
    let is_end: Bool
}
