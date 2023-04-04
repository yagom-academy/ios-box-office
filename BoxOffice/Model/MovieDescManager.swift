//
//  MovieDescManager.swift
//  BoxOffice
//
//  Created by 강민수 on 2023/04/03.
//

import Foundation

struct MovieDescManager {
    let apiType: APIType
    let boxofficeInfo: BoxofficeInfo<MovieInfoObject>
    var movieItem: MovieInfoObject?
    let movieImage: BoxofficeInfo<MovieImageObject>
    var imageUrl: String = ""
    
    init(apiType: APIType, session: URLSession = URLSession.shared) {
        self.apiType = apiType
        self.boxofficeInfo = BoxofficeInfo<MovieInfoObject>(apiType: apiType, model: NetworkModel(session: session))
        self.movieImage = BoxofficeInfo<MovieImageObject>(apiType: apiType, model: NetworkModel(session: session))
    }
    
    func makeImageUrl() {
        movieImage.fetchData { result in
            switch result {
            case .success(let data):
                imageUrl = data.documents[0].url
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
    }
    
}
