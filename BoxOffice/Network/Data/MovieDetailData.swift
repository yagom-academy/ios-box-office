//
//  MovieDetailData.swift
//  BoxOffice
//
//  Created by Toy, Morgan on 12/14/23.
//

import Foundation

struct MovieDetailData {
    private let networkManager = NetworkManager()
    private let movieDetailAPI = API(schema: MovieURL.schema, host: MovieURL.movieHost, path: MovieURL.movieDetailPath)
    private var movieDetailAPIAdditionalQueryItems: [URLQueryItem]
    
    private var getEndpoint: Endpoint {
        Endpoint(api: movieDetailAPI, queryItems: movieDetailAPIAdditionalQueryItems, httpMethod: .get, httpHeaderField: .contentType)
    }
    
    init(value: String) {
        movieDetailAPIAdditionalQueryItems = [ URLQueryItem(name: "movieCd", value: value) ]
    }
    
    func getMovieDetailData(complitionHandler: @escaping (MovieInfomation) -> Void) {
        networkManager.executeRequest(endponit: getEndpoint, type: Movie.self) { result in
            switch result {
            case .success(let safeData):
                let data = safeData.infomationResult.movieInfomation
                complitionHandler(data)
            case .failure(let error):
                print("\(error)에러발생")
            }
        }
    }
}
