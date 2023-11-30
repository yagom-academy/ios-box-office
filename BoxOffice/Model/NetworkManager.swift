//
//  NetworkManager.swift
//  BoxOffice
//
//  Created by jyubong on 11/30/23.
//

import Foundation

final class NetworkManager {
    static let shared = NetworkManager()
    
    let key = "3d65ed918572e0c8dc412bb3bf722f49"
    
    private init() { }
    
    func fetchDailyBoxOffice(at date: String, completion: @escaping (Movie?, Error?) -> Void) {
        guard let url = URL(string: "http://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=\(key)&targetDt=\(date)") else {
            completion(nil, FetchError.invalidURL)
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(nil, error)
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                (200...299).contains(httpResponse.statusCode) else {
                completion(nil, FetchError.invalidResponse)
                return
            }
            
            guard let data = data, let movie = try? JSONDecoder().decode(Movie.self, from: data) else {
                completion(nil, FetchError.invalidData)
                return
            }
            
            completion(movie, nil)
        }.resume()
    }
    
    func fetchMovieDetail() {
        
    }
}
