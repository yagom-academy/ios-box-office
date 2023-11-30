//
//  NetworkManager.swift
//  BoxOffice
//
//  Created by jyubong on 11/30/23.
//

import Foundation

final class NetworkManager {
    static let shared = NetworkManager()
    
    private let key = "3d65ed918572e0c8dc412bb3bf722f49"
    
    private init() { }
    
    func fetchDailyBoxOffice(at date: String, completion: @escaping (Result<[DailyBoxOfficeList], Error>) -> Void) {
        guard let url = URL(string: "http://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=\(key)&targetDt=\(date)") else {
            completion(.failure(FetchError.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                completion(.failure(FetchError.invalidResponse))
                return
            }
            
            guard let data = data, let movie = try? JSONDecoder().decode(Movie.self, from: data) else {
                completion(.failure(FetchError.invalidData))
                return
            }
            
            let dailyBoxOfficeList = movie.boxOfficeResult.dailyBoxOfficeList
            
            completion(.success(dailyBoxOfficeList))
        }.resume()
    }
    
    func fetchMovieDetail(code: String, completion: @escaping (Result<MovieInfo, Error>) -> Void) {
        guard let url = URL(string: "http://www.kobis.or.kr/kobisopenapi/webservice/rest/movie/searchMovieInfo.json?key=\(key)&movieCd=\(code)") else {
            completion(.failure(FetchError.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                (200...299).contains(httpResponse.statusCode) else {
                completion(.failure(FetchError.invalidResponse))
                return
            }
            
            guard let data = data, let movie = try? JSONDecoder().decode(MovieDetail.self, from: data) else {
                completion(.failure(FetchError.invalidData))
                return
            }
            
            let movieInfo = movie.movieInfoResult.movieInfo
            
            completion(.success(movieInfo))
        }.resume()
    }
}
