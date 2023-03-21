//
//  BoxOfficeOfToday.swift
//  BoxOffice
//
//  Created by Andrew, 레옹아범 on 2023/03/21.
//

import Foundation

class BoxOfficeOfToday {
    let targetDate: String
    let key = Bundle.main.apiKey
    var dailyBoxoffice: DailyBoxoffice?
    
    init(targetDate: String) {
        self.targetDate = targetDate
    }
    
    func search() {
        let url = URL(string: "http://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=\(key)&targetDt=\(targetDate)")!
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            if let error = error {
                return
            }
            guard let httpResponse = response as? HTTPURLResponse,
                (200...299).contains(httpResponse.statusCode) else {
                return
            }
            if let mimeType = httpResponse.mimeType, mimeType == "application/json;charset=utf-8",
               let data = data {
                do {
                    self?.dailyBoxoffice = try JSONDecoder().decode(DailyBoxoffice.self, from: data)
                    print(self?.dailyBoxoffice)
                } catch {
                    print(error.localizedDescription)
                    return
                }
            }
        }
        task.resume()
    }
}
