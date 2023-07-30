//
//  Genre.swift
//  BoxOffice
//
//  Created by Serena, BMO on 2023/07/28.
//

struct Genre: Decodable {
    let genreName: String // 장르 이름
    
    private enum CodingKeys: String, CodingKey {
        case genreName = "genreNm"
    }
}
