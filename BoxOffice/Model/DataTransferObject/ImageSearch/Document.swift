//
//  Document.swift
//  BoxOffice
//
//  Created by Idinaloq, MARY on 2023/08/09.
//

struct Document: Decodable {
    let imageURL: String

    enum CodingKeys: String, CodingKey {
        case imageURL = "image_url"
    }
}
