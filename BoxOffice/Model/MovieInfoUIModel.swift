//
//  MovieInfoUIModel.swift
//  BoxOffice
//
//  Created by Andrew on 2023/04/04.
//

import Foundation

struct MovieInfoUIModel {
    private let data: MovieInfoDescObject
    
    init(data: MovieInfoDescObject) {
        self.data = data
    }
    
    var directors: String {
        var directorsName = data.directors.map { $0.name }
        return directorsName.joined(separator: ", ")
    }
    
    var productedYear: String {
        return data.productedYear
    }
    
    var openDate: String {
        let dateFormatter = Date.dateFormatter
        guard let openDate = dateFormatter.date(from: data.openDate) else {
            return ""
        }
        return dateFormatter.string(from: openDate)
    }
    
    var showTime: String {
        return data.showTime
    }
    
    var audits: String {
        var auditsGrade = data.audits.map { $0.watchGradeNm }
        return auditsGrade.joined(separator: ", ")
    }
    
    var nations: String {
        var productNation = data.nations.map { $0.name }
        return productNation.joined(separator: ", ")
    }
    
    var genre: String {
        var movieGenre = data.genre.map { $0.name }
        return movieGenre.joined(separator: ", ")
    }
    
    var actors: String {
        var actors = data.actors.map { $0.name }
        return actors.joined(separator: ", ")
    }
    

}
