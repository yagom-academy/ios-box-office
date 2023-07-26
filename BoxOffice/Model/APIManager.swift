//
//  APIManager.swift
//  BoxOffice
//
//  Created by 박종화 on 2023/07/26.
//

import Foundation

struct APIManager {
    let session = URLSession.shared
    let urlString = "https://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=f5eef3421c602c6cb7ea224104795888&targetDt=202a30725"
    
    func fetchData() {
        guard let correctUrl = URL(string: urlString) else {
            print("Wrong URL")
            return
        }
        
        let request = URLRequest(url: correctUrl)
        
        session.dataTask(with: request) { data, response, error in
            guard error == nil else {
                print("error: \(String(describing: error))")
                return
            }
            
        }
    }
}
