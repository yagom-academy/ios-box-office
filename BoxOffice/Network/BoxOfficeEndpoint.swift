//
//  DataManager.swift
//  BoxOffice
//
//  Created by 김우현 on 12/13/23.
//

import Foundation

struct BoxOfficeEndpoint {
    private let networkManager = NetworkManager()
    private let boxofficeAPI = API(schema: MovieURL.schema, host: MovieURL.movieHost, path: MovieURL.boxofficePath)
    private let boxOfficeAPIAdditionalQueryItems = [ URLQueryItem(name: "targetDt", value: DateGenerator.fetchTodayDate()) ]
    
    var getBoxOfficeEndpoint: Endpoint {
       Endpoint(api: boxofficeAPI, queryItems: boxOfficeAPIAdditionalQueryItems, httpMethod: .get, httpHeaderField: .contentType)
    }
}
