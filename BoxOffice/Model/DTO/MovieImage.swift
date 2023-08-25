//
//  MovieImage.swift
//  BoxOffice
//
//  Created by Dasan & Whales on 2023/08/12.
//

struct MovieImage: Decodable {
    let meta: Meta
    let documents: [Document]
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

struct Document: Decodable, Hashable {
    let collection: String
    let thumbnailURL: String
    let imageURL: String
    let width: Int
    let height: Int
    let displaySiteName: String
    let documentURL: String
    let dateTime: String
    
    private enum CodingKeys: String, CodingKey {
        case collection
        case thumbnailURL = "thumbnail_url"
        case imageURL = "image_url"
        case width
        case height
        case displaySiteName = "display_sitename"
        case documentURL = "doc_url"
        case dateTime = "datetime"
    }
}
