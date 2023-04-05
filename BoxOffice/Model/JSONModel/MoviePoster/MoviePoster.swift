//
//  MoviePoster.swift
//  BoxOffice
//
//  Created by kaki, harry on 2023/03/29.
//

struct MoviePoster: Decodable {
    let items: [Item]
    
    private enum CodingKeys: String, CodingKey {
        case items = "documents"
    }
}

struct Item: Decodable {
    let imageURLText: String
    
    private enum CodingKeys: String, CodingKey {
        case imageURLText = "image_url"
    }
}
