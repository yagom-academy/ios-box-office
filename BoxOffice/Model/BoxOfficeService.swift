//
//  BoxOfficeService.swift
//  BoxOffice
//
//  Created by kimseongjun on 2023/04/05.
//

import Foundation

class BoxOfficeService {
    let provider = Provider()
    var dailyBoxOffice: DailyBoxOffice?
    var movieDetail: MovieDetail?
    var movieCode = ""
    
    func fetchDailyBoxOfficeAPI(completion: @escaping () -> Void) {
        var dailyBoxOfficeEndpoint = DailyBoxOfficeEndpoint()
        dailyBoxOfficeEndpoint.insertDateQueryValue(date: "20230327")
        
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
//            self.fetchImage()
            completion()
        }
    }
    
    func receiveMovieCode(movieCode: String) {
        self.movieCode = movieCode
    }
}


//DispatchQueue.main.async {
//    self.boxOfficeListCollectionView.reloadData()
//    self.activityIndicator.stopAnimating()
//}

//boxOfficeService.fetchMovieDetailAPI {
//                DispatchQueue.main.async {
//                    self.setMovieDetailLabel()
//                }
//}

//boxOfficeService.fetchMovieDetailAPI {
//    DispatchQueue.main.async {
//        self.setMovieDetailLabel()
//    }
//}
