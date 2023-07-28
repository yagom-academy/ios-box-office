//
//  NetworkManager.swift
//  BoxOffice
//
//  Created by EtialMoon, Minsup on 2023/07/25.
//

import Foundation

enum FetchType {
    case boxOffice(date: String)
    case movie(code: String)
}

enum NetworkManager {
    static func fetchData<T: Decodable>(fetchType: FetchType) async throws -> T {
        var urlString = "https://kobis.or.kr/kobisopenapi/webservice/rest/"
        
        switch fetchType {
        case .boxOffice(date: let date):
            urlString.append("boxoffice/searchDailyBoxOfficeList.json?key=c04de3c2ceec65d22a2c1a0b4cfe2b3c&targetDt=\(date)")
        case .movie(code: let code):
            urlString.append("movie/searchMovieInfo.json?key=c04de3c2ceec65d22a2c1a0b4cfe2b3c&movieCd=\(code)")
        }
        
        guard let url = URL(string: urlString) else {
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
        
        guard let decodedData = try? JSONDecoder().decode(T.self, from: data) else {
            throw DecodingError.decodingFailed
        }
        
        return decodedData
    }
}
