//
//  ViewController.swift
//  BoxOffice
//
//  Created by kjs on 13/01/23.
//

import UIKit

class ViewController: UIViewController {
    
    private var networkManager = NetworkManager()
    var data = BoxOfficeEndpoint()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        networkTest()
        test123()
    }
    
    func test123() {
        data.getBoxOfficeEndpoint { result in
            result.forEach { dump($0) }
        }
    }
    
    
    func networkTest() {
        let dailyBoxOfficeAPI = API(schema: MovieURL.schema, host: MovieURL.movieHost, path: MovieURL.boxofficePath)

        let dailyBoxOfficeAPIAdditionalQueryItems: [URLQueryItem] = [
            URLQueryItem(name: "targetDt", value: DateGenerator.fetchTodayDate())
        ]

        var movieCode = ""
        
        let endpoint = Endpoint(api: dailyBoxOfficeAPI, queryItems: dailyBoxOfficeAPIAdditionalQueryItems, httpMethod: .get, httpHeaderField: .contentType, mime: .json)

        let group = DispatchGroup()
        
        group.enter()
        networkManager.executeRequest(endponit: endpoint, type: BoxOffice.self) { result in
            defer {group.leave()}
            
            switch result {
            case .success(let safeData):
                let data = safeData.boxOfficeResult.dailyBoxOfficeList
                data.forEach {dump($0)}
                movieCode = data[0].movieCode
            case .failure(let error):
                print("\(error)에러발생")
            }
        }


        group.notify(queue: .main) {
            let movieDetailAPI = API(schema: MovieURL.schema, host: MovieURL.movieHost, path: MovieURL.movieDetailPath)
            
            let movieDetailAPIAdditionalQueryItems: [URLQueryItem] = [
                URLQueryItem(name: "movieCd", value: movieCode)
            ]
            
            let endpoint = Endpoint(api: movieDetailAPI, queryItems: movieDetailAPIAdditionalQueryItems, httpMethod: .get, httpHeaderField: .contentType, mime: .json)
            
            self.networkManager.executeRequest(endponit: endpoint, type: Movie.self) { result in
                switch result {
                case .success(let safeData):
                    let data = safeData.infomationResult.movieInfomation
                    print(data)
                case .failure(let error):
                    print("\(error)에러발생")
                }
            }
        }
    }
}

