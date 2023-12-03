//
//  MovieURL.swift
//  BoxOffice
//
//  Created by Toy, Morgan on 11/30/23.
//

import Foundation

struct MovieURL {
    enum DateFormat {
        static var yyyyMMdd = "yyyyMMdd"
    }
    
    private static let kobisURL = "https://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?"
    private static let detailURL = "https://www.kobis.or.kr/kobisopenapi/webservice/rest/movie/searchMovieInfo.json?"
    
    static var kobisURLString: String {
        return "\(self.kobisURL)key=\(Key.key)&targetDt=\(fetchTodayDate())"
    }
    
    static func detailURLString(movieCode: String) -> String {
        return "\(self.detailURL)key=\(Key.key)&movieCd=\(movieCode)"
    }
    
    private static func fetchTodayDate() -> String {
        let currentDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = DateFormat.yyyyMMdd
        
        guard let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: currentDate) else { return .emptyString }
        
        let targetDate = dateFormatter.string(from: yesterday)
        
        return targetDate
    }
}
