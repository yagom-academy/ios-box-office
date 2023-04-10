//
//  MovieInfoUIModel.swift
//  BoxOffice
//
//  Created by Andrew on 2023/04/04.
//

import Foundation

struct MovieInfoUIModel {
    private let data: MovieInfoDescObject
    
    var directors: String {
        let directorsName = data.directors.map { $0.name }
        return directorsName.isEmpty ? "감독 정보 없음" : directorsName.joined(separator: ", ")
    }
    
    var productedYear: String {
        return data.productedYear
    }
    
    var openDate: String {
        guard let openDate = Date.apiDateFormatter.date(from: data.openDate) else {
            return "개봉일 정보 없음"
        }
        return Date.dateFormatter.string(from: openDate)
    }
    
    var showTime: String {
        return data.showTime
    }
    
    var audits: String {
        let auditsGrade = data.audits.map { $0.watchGradeNm }
        return auditsGrade.joined(separator: ", ")
    }
    
    var nations: String {
        let productNation = data.nations.map { $0.name }
        return productNation.joined(separator: ", ")
    }
    
    var genre: String {
        let movieGenre = data.genre.map { $0.name }
        return movieGenre.joined(separator: ", ")
    }
    
    var actors: String {
        let actors = data.actors.map { $0.name }
        return actors.isEmpty ? "배우 정보 없음" : actors.joined(separator: ", ")
    }
    
    init(data: MovieInfoDescObject) {
        self.data = data
    }
}
