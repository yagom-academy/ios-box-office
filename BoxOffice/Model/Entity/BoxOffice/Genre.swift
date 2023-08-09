//
//  Genre.swift
//  BoxOffice
//
//  Created by Zion, Hemg on 2023/07/31.
//

struct Genre: Decodable {
    let genreName: String
    
    private enum CodingKeys: String, CodingKey {
        case genreName = "genreNm"
    }
}
