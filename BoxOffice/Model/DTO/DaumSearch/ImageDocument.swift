//
//  ImageDocument.swift
//  BoxOffice
//
//  Created by Serena, BMO on 2023/08/06.
//

import Foundation

struct ImageDocument: Decodable, DaumSearchDocumentable {
    let collection: String          // 컬렉션
    let thumbnailUrl: String        // 미리보기 이미지 URL
    let imageUrl: String            // 이미지 URL
    let width: Int                  // 이미지의 가로 길이
    let height: Int                 // 이미지의 세로 길이
    let displaySitename: String     // 출처
    let docUrl: String              // 문서 URL
    let datetime: String              // 문서 작성시간, ISO 8601
                                    // [YYYY]-[MM]-[DD]T[hh]:[mm]:[ss].000+[tz]
    
    private enum CodingKeys: String, CodingKey {
        case collection
        case thumbnailUrl = "thumbnail_url"
        case imageUrl = "image_url"
        case width
        case height
        case displaySitename = "display_sitename"
        case docUrl = "doc_url"
        case datetime
    }
}
