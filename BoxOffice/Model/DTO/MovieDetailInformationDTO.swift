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
    let nations: [Nation]
    let genres: [Genre]
    let directors: [Director]
    let actors: [MovieActor]
    let audits: [Audit]
}
