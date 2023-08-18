//
//  Model.swift
//  BoxOffice
//
//  Created by 훈민트 on 2023/08/18.
//

import Foundation

struct Model: DecodableModelProtocol {
    var networkManager: NetworkManager
    var type: Decodable
    var apiKey: URLQueryItem
    var queryItems: [String : String]
    
    init(networkManager: NetworkManager, type: Decodable, apiKey: URLQueryItem, queryItems: [String : String]) {
        self.networkManager = networkManager
        self.type = type
        self.apiKey = apiKey
        self.queryItems = queryItems
    }
}
