//
//  DaumImageEntity.swift
//  BoxOffice
//
//  Created by Yetti, Maxhyunm on 2023/08/08.
//
import Foundation

struct DaumImageEntity: Decodable {
    let meta: Meta
    let documents: [Document]
}

extension DaumImageEntity {
    struct Meta: Decodable {
        let totalCount, pageableCount: Int
        let isEnd: Bool
        
        enum CodingKeys: String, CodingKey {
            case totalCount = "total_count"
            case pageableCount = "pageable_count"
            case isEnd = "is_end"
        }
    }
}

extension DaumImageEntity {
    struct Document: Decodable {
        let collection, thumbnailURL, imageURL, displaySitename, documentURL, datetime: String
        let width, height: Int
        
        enum CodingKeys: String, CodingKey {
            case collection, width, height, datetime
            case thumbnailURL = "thumbnail_url"
            case imageURL = "image_url"
            case displaySitename = "display_sitename"
            case documentURL = "doc_url"
        }
    }
}
