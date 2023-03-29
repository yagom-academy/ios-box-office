//
//  MoviePoster.swift
//  BoxOffice
//
//  Created by kaki, harry on 2023/03/29.
//

struct MoviePoster: Decodable {
    let items: [Item]
}

struct Item: Decodable {
    let imageURLText: String
    
    enum CodingKeys: String, CodingKey {
        case imageURLText = "image"
    }
}
