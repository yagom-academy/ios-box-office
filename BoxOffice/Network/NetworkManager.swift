//
//  NetworkManager.swift
//  BoxOffice
//
//  Created by 훈민트 on 2023/08/15.
//

import Foundation

struct NetworkManager {    
    func configureRequest(url: URL, method: String = HTTPMethod.get.typeName) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = method
        
        return request
    }
    
    func fetchData(request: URLRequest, completion: @escaping (Result<Data, NetworkError>) -> Void) {
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if error != nil {
                completion(.failure(.dataTaskFail))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(.responseCasting))
                return
            }
            
            guard (200...299).contains(httpResponse.statusCode) else {
                completion(.failure(.invalidStatus))
                return
            }
            
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            
            completion(.success(data))
        }
        task.resume()
    }
}

//struct User {
//    private let networkManager: NetworkManager
//    private let model: Decodable
//    private let apiKey: URLQueryItem
//
//    init(networkManager: NetworkManager, model: Decodable, apiKey: URLQueryItem) {
//        self.networkManager = networkManager
//        self.model = model
//        self.apiKey = apiKey
//    }
//
//    func fetch() {
//        let apiKey = URLQueryItem(name: "key", value: "f5eef3421c602c6cb7ea224104795888")
//        var api = URLQuery()
//        api.addURLQueryItem(APIKey: apiKey, query: ["targetDt": "20120101"])
//        let url = URLType.boxOfficeData(query: api.queryItems).url
//        let request = networkManager.configureRequest(url: url)
//
//        networkManager.fetchData(request: request) { result in
//            switch result {
//            case .success(let data):
//                guard let decodedData = model.decode(data: data) else {
//                    return
//                }
//                print(decodedData)
//            case .failure(let error):
//                print(error.localizedDescription)
//            }
//        }
//    }
//}
