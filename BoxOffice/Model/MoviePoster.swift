//
//  MoviePoster.swift
//  BoxOffice
//
//  Created by Hyejeong Jeong on 2023/03/31.
//

import Foundation

struct MoviePoster: Decodable, Equatable {
    let documents: [Document]
}

// MARK: - Document
struct Document: Decodable, Equatable {
    let imageURL: String

    private enum CodingKeys: String, CodingKey {
        case imageURL = "image_url"
    }
}
