//
//  NetworkManager.swift
//  BoxOffice
//
//  Created by Serena, BMO on 2023/07/27.
//

import Foundation

struct NetworkManager {
    func loadData() {
        var components = URLComponents(string: "http://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json")
        let key = URLQueryItem(name: "key", value: "f5eef3421c602c6cb7ea224104795888")
        let targetDt = URLQueryItem(name: "targetDt", value: "20230101")
        components?.queryItems = [key, targetDt]
        let urlSession = URLSession(configuration: .default)
        guard let url = components?.url else { return }
        
        let task = urlSession.dataTask(with: url) { data, response, error in
            if let error = error {
                print("error 발생")
                return
            }
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                print("httpResponse error 발생")
                return
            }
            if let mimeType = httpResponse.mimeType,
               mimeType == "application/json",
               let data = data {
                let jsonDecoder = JSONDecoder()
                do {
                    let boxOffice = try jsonDecoder.decode(BoxOffice.self, from: data)
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
