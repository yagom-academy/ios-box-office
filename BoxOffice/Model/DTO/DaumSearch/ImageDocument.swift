//
//  ImageDocument.swift
//  BoxOffice
//
//  Created by Serena, BMO on 2023/08/06.
//

import Foundation

struct ImageDocument: Decodable, DaumSearchDocumentable {
    let collection: String          // 컬렉션
    let thumbnailURL: String        // 미리보기 이미지 URL
    let imageURL: String            // 이미지 URL
    let width: Int                  // 이미지의 가로 길이
    let height: Int                 // 이미지의 세로 길이
    let displaySiteName: String     // 출처
    let docURL: String              // 문서 URL
    let dateTime: String            // 문서 작성시간, ISO 8601
                                    // [YYYY]-[MM]-[DD]T[hh]:[mm]:[ss].000+[tz]
    
    private enum CodingKeys: String, CodingKey {
        case collection
        case thumbnailURL = "thumbnail_url"
        case imageURL = "image_url"
        case width
        case height
        case displaySiteName = "display_sitename"
        case docURL = "doc_url"
        case dateTime
    }
}
