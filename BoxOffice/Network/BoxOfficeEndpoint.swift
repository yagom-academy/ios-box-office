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
    

    func getBoxOfficeEndpoint(complitionHandler: @escaping ([DailyBoxOfficeItem]) -> Void){
        let endpoint = Endpoint(api: boxofficeAPI, queryItems: boxOfficeAPIAdditionalQueryItems, httpMethod: .get, httpHeaderField: .contentType)
        
        networkManager.executeRequest(endponit: endpoint, type: BoxOffice.self) { result in
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

//
//networkManager.executeRequest(endponit: endpoint, type: BoxOffice.self) { result in
//    switch result {
//    case .success(let safeData):
//        let data = safeData.boxOfficeResult.dailyBoxOfficeList
//        data.forEach { dump($0) }
//    case .failure(let error):
//        print("\(error)에러발생")
//    }
//}
