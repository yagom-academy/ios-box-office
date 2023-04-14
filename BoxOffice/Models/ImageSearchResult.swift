//
//  ImageSearchResult.swift
//  BoxOffice
//
//  Created by Seoyeon Hong on 2023/03/31.
//

import Foundation

struct ImageSearchResult: Decodable {
    let documents: [ImageInfo]
}

struct ImageInfo: Decodable {
    let imageUrl: String
    let width: Int
    let height: Int
    let docUrl: String
    
    enum CodingKeys: String, CodingKey {
        case imageUrl = "image_url"
        case width
        case height
        case docUrl = "doc_url"
        
    }
}
