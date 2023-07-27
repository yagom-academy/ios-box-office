//
//  NetworkManager.swift
//  BoxOffice
//
//  Created by EtialMoon, Minsup on 2023/07/25.
//

import Foundation

enum NetworkManager {
    static func getYesterdayBoxOffice() async throws -> [BoxOfficeItem] {
        guard let url = URL(string: "https://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=c04de3c2ceec65d22a2c1a0b4cfe2b3c&targetDt=20230724") else {
            throw NetworkError.invalidURL
        }
        
        guard let (data, response) = try? await URLSession.shared.data(from: url) else {
            throw NetworkError.requestFailed
        }
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.invalidHTTPResponse
        }
        
        guard (200..<300) ~= httpResponse.statusCode else {
            throw NetworkError.badStatusCode(statusCode: httpResponse.statusCode)
        }
        
        guard let boxOffice = try? JSONDecoder().decode(BoxOffice.self, from: data) else {
            throw DecodingError.decodingFailed
        }
        
        return boxOffice.boxOfficeResult.boxOfficeItems        
    }
    
    static func getMovieInformation(code: String) async throws -> MovieInformation {
        guard let url = URL(string: "https://www.kobis.or.kr/kobisopenapi/webservice/rest/movie/searchMovieInfo.json?key=c04de3c2ceec65d22a2c1a0b4cfe2b3c&movieCd=\(code)") else {
            throw NetworkError.invalidURL
        }
        
        guard let (data, response) = try? await URLSession.shared.data(from: url) else {
            throw NetworkError.requestFailed
        }
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.invalidHTTPResponse
        }
        
        guard (200..<300) ~= httpResponse.statusCode else {
            throw NetworkError.badStatusCode(statusCode: httpResponse.statusCode)
        }
        
        guard let movie = try? JSONDecoder().decode(Movie.self, from: data) else {
            throw DecodingError.decodingFailed
        }
        
        return movie.movieResult.movieInformation        
    }
}
