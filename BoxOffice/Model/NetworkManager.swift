//
//  NetworkManager.swift
//  BoxOffice
//
//  Created by vetto, brody on 23/03/20.
//
import Foundation

enum BoxOfficeAPI {
    case dailyBoxOffice(date: String)
    case detailMovieInformation(movieCode: String)
    
    static let key: String = "67e99e70400656a77208ca1775261071"
}

extension BoxOfficeAPI {
    var url: URL? {
        switch self {
        case .dailyBoxOffice(let date):
            let path = "boxoffice/searchDailyBoxOfficeList.json?"
            return .makeForEndpoint("\(path)key=\(BoxOfficeAPI.key)&targetDt=\(date)")
        case .detailMovieInformation(let movieCode):
            let path = "movie/searchMovieInfo.json?"
            return .makeForEndpoint("\(path)key=\(BoxOfficeAPI.key)&movieCd=\(movieCode)")
        }
    }
}

private extension URL {
    static let baseURL = "http://kobis.or.kr/kobisopenapi/webservice/rest/"
    
    static func makeForEndpoint(_ endpoint: String) -> URL? {
        guard let url = URL(string: baseURL + endpoint) else {
            return nil
        }
        return url
    }
}

final class NetworkManager {
    
    func fetchData<T: Decodable>(for url: URL?, type: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
        guard let url = url else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("local Error: \(error)")
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                print("server Error Response: \(response)")
                return
            }
            
            if let mimeType = httpResponse.mimeType, mimeType == "application/json",
               let data = data {
                do {
                    let jsonData = try JSONDecoder().decode(type, from: data)
                    completion(.success(jsonData))
                } catch {
                    print(error)
                }
                return
            }
        }
        task.resume()
    }
}
