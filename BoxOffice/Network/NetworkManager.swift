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
    
    func fetchData<T: Decodable>(type: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
        guard let url = URL(string: baseURL) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                return
            }
            
            guard (200...299).contains(httpResponse.statusCode) else {
                switch httpResponse.statusCode {
                case 400...499:
                    completion(.failure(NetworkingError.clientError))
                case 500...599:
                    completion(.failure(NetworkingError.serverError))
                default:
                    completion(.failure(NetworkingError.unknownError))
                }
                
                return
            }
            
            guard let data = data else {
                completion(.failure(NetworkingError.dataNotFound))
                
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
