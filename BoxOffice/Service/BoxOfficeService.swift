//
//  BoxOfficeService.swift
//  BoxOffice
//
//  Created by Serena, BMO on 2023/07/30.
//

import Foundation

struct BoxOfficeService {
    func loadDailyBoxOfficeData(_ completion: @escaping (BoxOffice) -> Void) {
        let yesterday = Date() - (24 * 60 * 60)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = CustomDateFormatStyle.yyyyMMdd
        let formattedYesterday = dateFormatter.string(from: yesterday)
        
        var components = URLComponents()
        components.scheme = KobisNameSpace.scheme
        components.host = KobisNameSpace.host
        components.path = KobisNameSpace.dailyBoxOfficePath
        
        let key = URLQueryItem(name: KobisNameSpace.key,
                               value: KobisNameSpace.keyValue)
        let targetDt = URLQueryItem(name: KobisNameSpace.targetDt,
                                    value: formattedYesterday)
        
        components.queryItems = [key, targetDt]
        
        NetworkManager.loadData(components, BoxOffice.self, completion)
    }
    
    
    func loadMovieDetailData(movieCd: String, _ completion: @escaping (Movie) -> Void) {
        var components = URLComponents()
        components.scheme = KobisNameSpace.scheme
        components.host = KobisNameSpace.host
        components.path = KobisNameSpace.detailMovieInfoPath
        
        let key = URLQueryItem(name: KobisNameSpace.key,
                               value: KobisNameSpace.keyValue)
        let movieCd = URLQueryItem(name: KobisNameSpace.movieCd,
                                   value: movieCd)
        
        components.queryItems = [key, movieCd]
        
        NetworkManager.loadData(components, Movie.self, completion)
    }
}
