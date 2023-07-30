//
//  NetworkManager.swift
//  BoxOffice
//
//  Created by Serena, BMO on 2023/07/27.
//

import Foundation

struct NetworkManager {
    static func loadData<T: Decodable>(_ components: URLComponents?, _ dataType: T.Type, _ completion: @escaping (_ dataType: T) -> Void) {
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
