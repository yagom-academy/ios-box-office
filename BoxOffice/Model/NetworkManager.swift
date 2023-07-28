//
//  NetworkManager.swift
//  BoxOffice
//
//  Created by Serena, BMO on 2023/07/27.
//

import Foundation

struct NetworkManager {
    func loadDailyBoxOfficeData(_ completion: @escaping (BoxOffice) -> Void) {
        let yesterday = Date() - (24 * 60 * 60)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = CustomDateFormatStyle.yyyyMMdd
        let formattedYesterday = dateFormatter.string(from: yesterday)
        
        var components = URLComponents()
        components.scheme = KobisNameSpace.scheme
        components.host = KobisNameSpace.host
        components.path = KobisNameSpace.dailyBoxOfficePath
        
        let key = URLQueryItem(name: KobisNameSpace.key,
                               value: KobisNameSpace.keyValue)
        let targetDt = URLQueryItem(name: KobisNameSpace.targetDt,
                                    value: formattedYesterday)
        
        components.queryItems = [key, targetDt]
        
        loadData(components, BoxOffice.self, completion)
    }
    
    
    func loadMovieDetailData(movieCd: String, _ completion: @escaping (Movie) -> Void) {
        var components = URLComponents()
        components.scheme = KobisNameSpace.scheme
        components.host = KobisNameSpace.host
        components.path = KobisNameSpace.detailMovieInfoPath
        
        let key = URLQueryItem(name: KobisNameSpace.key,
                               value: KobisNameSpace.keyValue)
        let movieCd = URLQueryItem(name: KobisNameSpace.movieCd,
                                   value: movieCd)
        
        components.queryItems = [key, movieCd]
        
        loadData(components, Movie.self, completion)
    }
}

extension NetworkManager {
    private func loadData<T: Decodable>(_ components: URLComponents?, _ dataType: T.Type, _ completion: @escaping (_ dataType: T) -> Void) {
        let urlSession = URLSession(configuration: .default)
        
        guard let url = components?.url else {
            print("url이 없습니다.")
            return
        }
        
        let task = urlSession.dataTask(with: url) { data, response, error in
            if let error {
                print("error 발생: \(error)")
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                print("httpResponse error 발생")
                return
            }
            
            if let mimeType = httpResponse.mimeType,
               mimeType == MimeType.jsonFormat,
               let data {
                let jsonDecoder = JSONDecoder()
                do {
                    let result: T = try jsonDecoder.decode(T.self, from: data)
                    completion(result)
                } catch let error as JSONDecoderError {
                    print("JSONDecoder 에러 : \(error)")
                } catch {
                    print("알 수 없는 에러 발생")
                }
            }
        }
        
        task.resume()
    }
}
