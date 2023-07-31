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
    
    var url: URL? {
        switch self {
        case .boxOffice(let date):
            return URL(string: "https://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=c04de3c2ceec65d22a2c1a0b4cfe2b3c&targetDt=\(date)")
        case .movie(let code):
            return URL(string: "https://kobis.or.kr/kobisopenapi/webservice/rest/movie/searchMovieInfo.json?key=c04de3c2ceec65d22a2c1a0b4cfe2b3c&movieCd=\(code)")
        }
    }
}

enum NetworkManager {
    static func fetchData<T: Decodable>(fetchType: FetchType) async throws -> T {
        
        guard let url = fetchType.url else {
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
        
        return try decode(from: data)
    }
    
    static private func decode<T: Decodable>(from data: Data) throws -> T {
        guard let decoded = try? JSONDecoder().decode(T.self, from: data) else {
            throw DecodingError.decodingFailed
        }
        return decoded
    }
}
