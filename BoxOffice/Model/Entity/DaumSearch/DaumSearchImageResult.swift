//
//  DaumSearchImageResult.swift
//  BoxOffice
//
//  Created by Hyungmin Lee on 2023/08/09.
//

struct DaumSearchImageResult: Decodable {
    let documents: [ImageInformation]

    struct ImageInformation: Decodable {
        let collection: String
        let dateTime: String
        let dispalySiteName: String
        let docURL: String
        let height: Int
        let imageURL: String
        let thumbnailURL: String
        let width: Int

        private enum CodingKeys: String, CodingKey {
            case collection
            case dateTime = "datetime"
            case dispalySiteName = "display_sitename"
            case docURL = "doc_url"
            case height
            case imageURL = "image_url"
            case thumbnailURL = "thumbnail_url"
            case width
        }
    }
}
