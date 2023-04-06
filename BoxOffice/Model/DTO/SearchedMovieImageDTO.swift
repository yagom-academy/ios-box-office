//
//  SearchedMovieImageDTO.swift
//  BoxOffice
//
//  Created by vetto, brody on 23/03/30.
//
import Foundation

struct SearchedMovieImageDTO: Decodable {
    let meta: MetaData
    let documents: [Document]
    
    struct MetaData: Decodable {
        let totalCount: Int
        let pageableCount: Int
        let isEnd: Bool
        
        private enum CodingKeys: String, CodingKey {
            case totalCount = "total_count"
            case pageableCount = "pageable_count"
            case isEnd = "is_end"
        }
    }
    
    struct Document: Decodable {
        let collection: String
        let thumbnailURL: String
        let imageURL: String
        let width: Int
        let height: Int
        let displaySiteName: String
        let docURL: String
        let dateTime: String
        
        private enum CodingKeys: String, CodingKey {
            case collection
            case thumbnailURL = "thumbnail_url"
            case imageURL = "image_url"
            case width
            case height
            case displaySiteName = "display_sitename"
            case docURL = "doc_url"
            case dateTime = "datetime"
        }
    }
}
