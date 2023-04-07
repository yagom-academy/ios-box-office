//
//  BoxOfficeService.swift
//  BoxOffice
//
//  Created by goat, songjun on 2023/04/05.
//

import Foundation

class BoxOfficeService {
    let provider = Provider()
    var dailyBoxOffice: DailyBoxOffice?
    var movieDetail: MovieDetail?
    var movieCode = ""
    
    func fetchDailyBoxOfficeAPI(date: String,completion: @escaping () -> Void) {
        var dailyBoxOfficeEndpoint = DailyBoxOfficeEndpoint()
        dailyBoxOfficeEndpoint.insertDateQueryValue(date: date)
        
        provider.loadBoxOfficeAPI(endpoint: dailyBoxOfficeEndpoint,
                                  parser: Parser<DailyBoxOffice>()) { parsedData in
            self.dailyBoxOffice = parsedData
            completion()
        }
    }
    
    func fetchMovieDetailAPI(completion: @escaping () -> Void) {
        var movieDetailEndpoint = MovieDetailEndpoint()
        movieDetailEndpoint.insertMovieCodeQueryValue(movieCode: movieCode)
        
        provider.loadBoxOfficeAPI(endpoint: movieDetailEndpoint,
                                  parser: Parser<MovieDetail>()) { parsedData in
            self.movieDetail = parsedData
            completion()
        }
    }
    
    func receiveMovieCode(movieCode: String) {
        self.movieCode = movieCode
    }
}
