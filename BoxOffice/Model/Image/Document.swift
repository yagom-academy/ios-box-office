//
//  Document.swift
//  BoxOffice
//
//  Created by karen on 2023/08/19.
//

struct Document: Decodable {
    let url: String
    let width: Int
    let height: Int
    
    private enum CodingKeys: String, CodingKey {
        case url = "image_url"
        case width, height
    }
}
