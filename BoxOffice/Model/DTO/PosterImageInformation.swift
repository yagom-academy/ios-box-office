//
//  PosterImageInformation.swift
//  BoxOffice
//
//  Created by kyungmin, Erick on 2023/08/05.
//

struct PosterImageInformation: Decodable {
    let documents: [Document]
    let meta: Meta
}

struct Document: Decodable {
    let collection: String
    let datetime: String
    let displaySitename: String
    let docURL: String
    let height: Int
    let imageURL: String
    let thumbnailURL: String
    let width: Int

    private enum CodingKeys: String, CodingKey {
        case collection
        case datetime
        case displaySitename = "display_sitename"
        case docURL = "doc_url"
        case height
        case imageURL = "image_url"
        case thumbnailURL = "thumbnail_url"
        case width
    }
}

struct Meta: Decodable {
    let isEnd: Bool
    let pageableCount: Int
    let totalCount: Int

    private enum CodingKeys: String, CodingKey {
        case isEnd = "is_end"
        case pageableCount = "pageable_count"
        case totalCount = "total_count"
    }
}
