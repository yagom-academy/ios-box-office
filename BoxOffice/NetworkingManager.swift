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
                print(BoxOfficeError.connectionFailure.description)
                return
            }
            
            // 서버 에러
            guard let httpResponse = response as? HTTPURLResponse else {
                print(BoxOfficeError.notHttpUrlResponse.description)
                return
            }
            
            guard (200...299).contains(httpResponse.statusCode) else {
                print(BoxOfficeError.invalidResponse(statusCode: httpResponse.statusCode).description)
                return
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
