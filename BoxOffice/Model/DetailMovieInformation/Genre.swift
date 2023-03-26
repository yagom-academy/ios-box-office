//
//  Genre.swift
//  BoxOffice
//
//  Created by Rhode, Rilla on 2023/03/21.
//

struct Genre: Decodable {
    let genreName: String
        
    private enum CodingKeys: String, CodingKey {
        case genreName = "genreNm"
    }
}
