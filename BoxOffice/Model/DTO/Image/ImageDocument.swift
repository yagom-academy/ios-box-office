//
//  ImageDocument.swift
//  BoxOffice
//
//  Created by EtialMoon, Minsup on 2023/08/08.
//

struct ImageDocument: Decodable {
    let collection: String
    let thumbnail_url: String
    let imageURL: String
    let width: Int
    let height: Int
    let display_sitename: String
    let doc_url: String
    let datetime: String
    
    private enum CodingKeys: String, CodingKey {
        case collection
        case thumbnail_url
        case imageURL = "image_url"
        case width
        case height
        case display_sitename
        case doc_url
        case datetime
    }
}
