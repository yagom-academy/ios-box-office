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
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                return completion(nil, error)
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                (200...299).contains(httpResponse.statusCode) else {
                return completion(nil, error)
            }
            
            if let data = data, let movie = try? JSONDecoder().decode(Movie.self, from: data) {
                completion(movie, nil)
            }
        }.resume()
    }
    
    func fetchMovieDetail() {
        
    }
}
