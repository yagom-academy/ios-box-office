//
//  MovieDetailInformationDTO.swift
//  BoxOffice
//
//  Created by Zion, Hemg on 2023/08/09.
//

struct MovieDetailInformationDTO {
    let showTime: String
    let productYear: String
    let openDate: String
    let nations: [String]
    let genres: [String]
    let directors: [String]
    let movieActors: [String]
    let watchGrade: String
}

extension MovieDetailInformationDTO {
    func isMovieActorsEmpty() -> Bool {
        return directors.count == 0
    }
}
