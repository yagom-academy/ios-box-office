//
//  NetworkingManager.swift
//  BoxOffice
//
//  Created by Yetti, Maxhyunm on 2023/07/26.
//
import Foundation

struct NetworkingManager {
    let session = URLSession.shared
    var delegate: NetworkingDelegate?
    
    func load(_ urlString: String) {
        guard let url = URL(string: urlString) else {
            return
        }
        
        let task = session.dataTask(with: url) { data, response, error in
            // 연결 에러
            if error != nil {
                print(error!) // 에러처리 필요
            }
            
            // 서버 에러
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                return // 에러처리 필요
            }
            
            if let mimeType = httpResponse.mimeType,
               mimeType == "application/json",
               let rawData = data,
               let string = String(data: rawData, encoding: .utf8),
               let data = string.data(using: .utf8) {
                delegate?.setReceivedData(data)
            }
        }
        task.resume()
    }
}
