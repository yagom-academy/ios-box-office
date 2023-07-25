//
//  NetworkManager.swift
//  BoxOffice
//
//  Created by EtialMoon, Minsup on 2023/07/25.
//

import Foundation

enum NetworkManager {
    static func getDailyBoxOfficeData() {
        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration)
        let urlComponents = URLComponents(string: "https://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=c04de3c2ceec65d22a2c1a0b4cfe2b3c&targetDt=20230724")
        let requestURL = urlComponents!.url!
        
        let dataTask = session.dataTask(with: requestURL) { data, response, error in
            let successRange = 200..<300
            
            guard error == nil,
                  let statusCode = (response as? HTTPURLResponse)?.statusCode,
                  successRange.contains(statusCode) else {
                return
            }
            
            guard let resultData = data else {
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let dailyBoxOffice = try decoder.decode(BoxOffice.self, from: resultData)
                
                print(dailyBoxOffice)
            } catch {
                print(error)
            }
        }
        
        dataTask.resume()
    }
}
