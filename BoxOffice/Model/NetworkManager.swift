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
        dateFormatter.dateFormat = "yyyyMMdd"
        let formattedYesterday = dateFormatter.string(from: yesterday)
        
        var components = URLComponents(string: "http://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json")
        let key = URLQueryItem(name: "key", value: "f5eef3421c602c6cb7ea224104795888")
        let targetDt = URLQueryItem(name: "targetDt", value: formattedYesterday)
        
        components?.queryItems = [key, targetDt]
        
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
               mimeType == "application/json",
               let data {
                let jsonDecoder = JSONDecoder()
                do {
                    let boxOffice: BoxOffice = try jsonDecoder.decode(BoxOffice.self, from: data)
                    completion(boxOffice)
                } catch let error as JSONDecoderError {
                    print("JSONDecoder 에러 : \(error)")
                } catch {
                    print("알 수 없는 에러 발생")
                }
            }
        }
        
        task.resume()
    }
    
    
    func loadMovieDetailData(movieCd: String, _ completion: @escaping (Movie) -> Void) {
        var components = URLComponents(string: "http://www.kobis.or.kr/kobisopenapi/webservice/rest/movie/searchMovieInfo.json")
        let key = URLQueryItem(name: "key", value: "f5eef3421c602c6cb7ea224104795888")
        let movieCd = URLQueryItem(name: "movieCd", value: movieCd)
        
        components?.queryItems = [key, movieCd]
        
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
               mimeType == "application/json",
               let data {
                let jsonDecoder = JSONDecoder()
                do {
                    let movie: Movie = try jsonDecoder.decode(Movie.self, from: data)
                    completion(movie)
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
