//
//  ViewController.swift
//  BoxOffice
//
//  Created by kjs on 13/01/23.
//

import UIKit

class ViewController: UIViewController {
    
    private var networkManager = NetworkManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        networkTest()
    }
    
    func networkTest() {
        let dailyBoxOfficeAPI = API(schema: MovieURL.schema, host: MovieURL.movieHost, path: MovieURL.boxofficePath)

        let dailyBoxOfficeAPIAdditionalQueryItems: [URLQueryItem] = [
            URLQueryItem(name: "targetDt", value: DateGenerator.fetchTodayDate())
        ]

        let apiKey = Key.movieDataApiKey

        var movieCode = ""

        let group = DispatchGroup()
        
        group.enter()
        networkManager.executeRequest(api: dailyBoxOfficeAPI, apiKey: apiKey, queryItems: dailyBoxOfficeAPIAdditionalQueryItems, type: BoxOffice.self, complitionHandler: { result in
            defer {group.leave()}
            
            switch result {
            case .success(let safeData):
                let data = safeData.boxOfficeResult.dailyBoxOfficeList
                data.forEach {dump($0)}
                movieCode = data[0].movieCode
            case .failure(let error):
                print("\(error)에러발생")
            }
        })


        group.notify(queue: .main) {
            let movieDetailAPI = API(schema: MovieURL.schema, host: MovieURL.movieHost, path: MovieURL.movieDetailPath)
            
            let movieDetailAPIAdditionalQueryItems: [URLQueryItem] = [
                URLQueryItem(name: "movieCd", value: movieCode)
            ]
            
            self.networkManager.executeRequest(api: movieDetailAPI, apiKey: apiKey, queryItems: movieDetailAPIAdditionalQueryItems, type: Movie.self) { result in
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

