//
//  SearchedResult.swift
//  BoxOffice
//
//  Created by Muri, Rowan on 2023/03/29.
//

struct DaumSearchResult: Decodable {
    let documents: [Document]
    let metadata: Metadata
    
    enum CodingKeys: String, CodingKey {
        case documents
        case metadata = "meta"
    }
}

struct Document: Decodable {
    let source: Source
    let date: String
    let displaySiteName: String
    let documentURL: String
    let height: Int
    let imageURL: String
    let thumbnailURL: String
    let width: Int

    enum CodingKeys: String, CodingKey {
        case source = "collection"
        case date = "datetime"
        case displaySiteName = "display_sitename"
        case documentURL = "doc_url"
        case height
        case imageURL = "image_url"
        case thumbnailURL = "thumbnail_url"
        case width
    }
}

enum Source: String, Decodable {
    case blog = "blog"
    case cafe = "cafe"
    case etc = "etc"
    case news = "news"
}

struct Metadata: Decodable {
    let isEnd: Bool
    let pageableCount, totalCount: Int

    enum CodingKeys: String, CodingKey {
        case isEnd = "is_end"
        case pageableCount = "pageable_count"
        case totalCount = "total_count"
    }
}
