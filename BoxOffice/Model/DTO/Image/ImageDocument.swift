//
//  ImageDocument.swift
//  BoxOffice
//
//  Created by EtialMoon, Minsup on 2023/08/08.
//

struct ImageDocument: Decodable {
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
