//
//  NetworkManager.swift
//  BoxOffice
//
//  Created by EtialMoon, Minsup on 2023/07/25.
//

import UIKit

enum FetchType {
    case boxOffice(date: String)
    case movie(code: String)
    case image(movieName: String)
    
    var url: String {
        switch self {
        case .boxOffice:
            return "http://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json"
        case .movie:
            return "http://kobis.or.kr/kobisopenapi/webservice/rest/movie/searchMovieInfo.json"
        case .image:
            return "https://dapi.kakao.com/v2/search/image"
        }
    }
}

enum NetworkManager {
    
    static func fetchImage(movieName: String) async throws -> UIImage? {
        let image: Image = try await fetchData(fetchType: .image(movieName: movieName))
        
        guard let urlString = image.imageDocuments.first?.imageURL,
              let url = URL(string: urlString),
              let data = try? Data(contentsOf: url) else {
            return nil
        }
        
        return UIImage(data: data)
    }
    
    static func fetchData<T: Decodable>(fetchType: FetchType) async throws -> T {
        
        guard let request = createRequest(fetchType: fetchType) else {
            throw NetworkError.invalidURL
        }
        
        guard let (data, response) = try? await URLSession.shared.data(for: request) else {
            throw NetworkError.requestFailed
        }
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.invalidHTTPResponse
        }
        
        guard (200..<300) ~= httpResponse.statusCode else {
            throw NetworkError.badStatusCode(statusCode: httpResponse.statusCode)
        }
        
        return try JSONDecodingManager.decode(from: data)
    }
    
    static private func createRequest(fetchType: FetchType) -> URLRequest? {
        guard var urlComponents = URLComponents(string: fetchType.url) else {
            return nil
        }
        
        switch fetchType {
        case .boxOffice(let date):
            urlComponents.queryItems = [
                URLQueryItem(name: "key", value: Bundle.main.kobisAPIKey),
                URLQueryItem(name: "targetDt", value: date)
            ]
            
            guard let url = urlComponents.url else {
                return nil
            }
            
            return URLRequest(url: url)
        case .movie(let code):
            urlComponents.queryItems = [
                URLQueryItem(name: "key", value: Bundle.main.kobisAPIKey),
                URLQueryItem(name: "movieCd", value: code)
            ]
            
            guard let url = urlComponents.url else {
                return nil
            }
            
            return URLRequest(url: url)
        case .image(let movieName):
            urlComponents.queryItems = [URLQueryItem(name: "query", value: "\(movieName)+영화+포스터")]
            
            guard let url = urlComponents.url else {
                return nil
            }
            
            var request = URLRequest(url: url)
            
            request.addValue(Bundle.main.kakaoAPIKey, forHTTPHeaderField: "Authorization")
            
            return request
        }
    }
}
