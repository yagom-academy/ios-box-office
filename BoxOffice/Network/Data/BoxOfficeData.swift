//
//  DataManager.swift
//  BoxOffice
//
//  Created by Toy, Morgan on 12/13/23.
//

import Foundation

struct BoxOfficeData {
    private let networkManager = NetworkManager()
    private let boxofficeAPI = API(schema: MovieURL.schema, host: MovieURL.movieHost, path: MovieURL.boxofficePath)
    private let boxOfficeAPIAdditionalQueryItems = [ URLQueryItem(name: "targetDt", value: DateGenerator.fetchTodayDate()) ]
    
    private var getEndpoint: Endpoint {
        Endpoint(api: boxofficeAPI, queryItems: boxOfficeAPIAdditionalQueryItems, httpMethod: .get, httpHeaderField: .contentType)
    }

    func getBoxOfficeData(complitionHandler: @escaping ([DailyBoxOfficeItem]) -> Void) {
        networkManager.executeRequest(endponit: getEndpoint, type: BoxOffice.self) { result in
            switch result {
            case .success(let safeData):
                let data = safeData.boxOfficeResult.dailyBoxOfficeList
                complitionHandler(data)
            case .failure(let error):
                print("\(error)에러발생")
            }
        }
    }
}
