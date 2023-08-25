//
//  MovieDetailUIModel.swift
//  BoxOffice
//
//  Created by karen on 2023/08/19.
//

import Foundation

struct MovieDetailUIModel {
    private let data: MovieInfoDescription
    
    var directors: String {
        let directorsName = data.directors.map { $0.name }
        return directorsName.isEmpty ? "감독 정보 없음" : directorsName.joined(separator: ", ")
    }
    
    var productedYear: String {
        return data.productionYear
    }
    
    var releaseDate: String {
        guard let releaseDate = Date.apiDateFormatter.date(from: data.releaseDate) else {
            return "개봉일 정보 없음"
        }
        return Date.dateFormatter.string(from: releaseDate)
    }
    
    var showTime: String {
        return data.showTime
    }
    
    var audits: String {
        let auditsGrade = data.audits.map { $0.watchGradeName }
        return auditsGrade.joined(separator: ", ")
    }
    
    var nations: String {
        let productNation = data.nations.map { $0.name }
        return productNation.joined(separator: ", ")
    }
    
    var genre: String {
        let movieGenre = data.genres.map { $0.name }
        return movieGenre.joined(separator: ", ")
    }
    
    var actors: String {
        let actors = data.actors.map { $0.name }
        return actors.isEmpty ? "배우 정보 없음" : actors.joined(separator: ", ")
    }
    
    init(data: MovieInfoDescription) {
        self.data = data
    }
}
