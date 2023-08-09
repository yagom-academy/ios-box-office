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
    let movieActors: [MovieActor]
    let audits: [Audit]
}

extension MovieDetailInformationDTO {
    func convertNationsToText() -> String {
        return nations.map { $0.nationName }.joined(separator: ", ")
    }
    
    func convertGenresToText() -> String {
        return genres.map { $0.genreName }.joined(separator: ", ")
    }
    
    func convertDirectorsToText() -> String {
        return directors.map { $0.peopleName }.joined(separator: ", ")
    }
    
    func convertMovieActorsToText() -> String {
        return movieActors.map { $0.peopleName }.joined(separator: ", ")
    }
    
    func convertAuditsToText() -> String {
        return audits.first?.watchGradeName ?? ""
    }
    
    func isMovieActorsEmpty() -> Bool {
        return movieActors.count == 0
    }
}
