//
//  MovieAPI.swift
//  BoxOffice
//
//  Created by goat, songjun on 2023/03/21.
//

import Foundation

struct DailyBoxOfficeAPI {
    let dailyBoxOfficeParser = Parser<DailyBoxOffice>()
    
    func loadDailyBoxOffice() {
        guard let url = URL(string: "http://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=f5eef3421c602c6cb7ea224104795888&targetDt=20120101") else {
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let validData = data else { return }
            print(dailyBoxOfficeParser.Parse(data: validData)?.boxOfficeResult.showRange)
            
            guard let httpURLResponse = response as? HTTPURLResponse, (200...299).contains(httpURLResponse.statusCode) else {
                print("response")
                return
            }
            DispatchQueue.main.async {}
                    
        }.resume()
    }
}
