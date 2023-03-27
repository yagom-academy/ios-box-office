//
//  Genre.swift
//  BoxOffice
//
//  Created by kaki, harry on 2023/03/27.
//

struct Genre: Decodable {
    let genreName: String
    
    enum CodingKeys: String, CodingKey {
        case genreName = "genreNm"
    }
}
