//
//  Document.swift
//  BoxOffice
//
//  Created by Rhode, Rilla on 2023/04/01.
//

struct Document: Codable {
    let collection: String
    let thumbnailURL: String
    let imageURL: String
    let width: Int
    let height: Int
    let displaySiteName: String
    let docURL: String
    let dateTime: String

    enum CodingKeys: String, CodingKey {
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

