//
//  NetworkManager.swift
//  BoxOffice
//
//  Created by EtialMoon, Minsup on 2023/07/25.
//

import Foundation

enum NetworkManager {
    static let urlString = "https://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=c04de3c2ceec65d22a2c1a0b4cfe2b3c&targetDt=20230724"
    
    static func getYesterdayBoxOffice() async throws -> [BoxOfficeItem] {
        guard let url = URL(string: urlString ) else {
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
}
