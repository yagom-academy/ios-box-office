//
//  MoviePosterImage.swift
//  BoxOffice
//
//  Created by 리지, kokkilE on 2023/03/30.
//

struct MoviePosterImage: Decodable {
    let documents: [Document]
    let metaData: Meta
    
    enum CodingKeys: String, CodingKey {
        case documents
        case metaData = "meta"
    }
    
    struct Document: Decodable {
        let collection: String
        let datetime: String
        let displaySitename: String
        let documentURL: String
        let height: Int
        let imageURL: String
        let thumbnailURL: String
        let width: Int
        
        enum CodingKeys: String, CodingKey {
            case collection, datetime
            case displaySitename = "display_sitename"
            case documentURL = "doc_url"
            case height
            case imageURL = "image_url"
            case thumbnailURL = "thumbnail_url"
            case width
        }
    }
    
    struct Meta: Decodable {
        let isEnd: Bool
        let pageableCount, totalCount: Int
        
        enum CodingKeys: String, CodingKey {
            case isEnd = "is_end"
            case pageableCount = "pageable_count"
            case totalCount = "total_count"
        }
    }
}
