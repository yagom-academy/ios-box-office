//
//  MoviePoster.swift
//  BoxOffice
//
//  Created by Hyejeong Jeong on 2023/03/31.
//

import Foundation

struct MoviePoster: Codable {
    let documents: [Document]
}

// MARK: - Document
struct Document: Codable {
    let imageURL: String

    enum CodingKeys: String, CodingKey {
        case imageURL = "image_url"
    }
}
