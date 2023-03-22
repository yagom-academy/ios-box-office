//
//  NetworkManager.swift
//  BoxOffice
//
//  Created by Christy, Hyemory on 2023/03/21.
//

import Foundation

class NetworkManager {
    var dataStructure: BoxOffice?
    let key = "8482fc9ad040e88431f60965446b6a19"
    let targetDate = "20140101"
    lazy var baseURL = "https://www.kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=\(key)&targetDt=\(targetDate)"

    func fetchData() {
        guard let url = URL(string: baseURL) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("error 오류!", error.localizedDescription)
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                print("httpResponse 오류!")
                return
            }
            
            guard let data = data else {
                print("데이터 가져오기 실패!")
                return
            }

            self.dataStructure = try? FileDecoder().decodeData(data, type: BoxOffice.self).get()

            DispatchQueue.main.async { [weak self] in
                print(self?.dataStructure?.result.dailyBoxOfficeList.last ?? "nilnilnilnil")
            }
        }
        task.resume()
    }
}
