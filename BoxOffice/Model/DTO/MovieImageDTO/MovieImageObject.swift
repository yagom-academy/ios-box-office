//
//  MovieImageObject.swift
//  BoxOffice
//
//  Created by Andrew on 2023/04/03.
//

import Foundation

struct MovieImageObject: Decodable {
    let documents: [Document]
}

struct Document: Decodable {
    let url: String
    let width: Int
    let height: Int
    
    private enum CodingKeys: String, CodingKey {
        case url = "image_url"
        case width, height
    }
}


