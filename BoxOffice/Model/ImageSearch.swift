//
//  PosterImage.swift
//  BoxOffice
//
//  Created by kimseongjun on 2023/03/30.
//

import UIKit

struct ImageSearch: Decodable {
    let imageDatas: [ImageData]
    
    private enum CodingKeys: String, CodingKey {
        case imageDatas = "documents"
    }
}

struct ImageData: Decodable {
    let collection: String
    let dateTime: String
    let displaySiteName: String
    let documentURL: String
    let imageHeight: Int
    let imageURL: String
    let thumbnailURL: String
    let imageWidth: Int
    
    private enum CodingKeys: String, CodingKey {
        case collection
        case dateTime = "datetime"
        case displaySiteName = "display_sitename"
        case documentURL = "doc_url"
        case imageHeight = "height"
        case imageURL = "image_url"
        case thumbnailURL = "thumbnail_url"
        case imageWidth = "width"
    }
}
