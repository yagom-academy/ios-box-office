//
//  DecodableModelProtocol.swift
//  BoxOffice
//
//  Created by 훈민트 on 2023/08/18.
//

import Foundation

protocol DecodableModelProtocol {
    var networkManager: NetworkManager { get }
    var type: Decodable { get }
    var apiKey: URLQueryItem { get }
    var queryItems: [String: String] { get }

    func makeRequest() -> URLRequest
    func fetch()
}

extension DecodableModelProtocol {
    func makeRequest() -> URLRequest {
        var api = URLQuery()
        api.addURLQueryItem(APIKey: apiKey, query: queryItems)
        let url = URLType.boxOfficeData(query: api.queryItems).url
        let request = networkManager.configureRequest(url: url)
        
        return request
    }
    
    func fetch() {
        networkManager.fetchData(request: makeRequest()) { result in
            switch result {
            case .success(let data):
                guard let decodedData = type.decode(data: data) else {
                    return
                }
                print(decodedData)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
