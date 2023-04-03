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
    
    init(apiType: APIType, session: URLSession = URLSession.shared) {
        self.apiType = apiType
        self.boxofficeInfo = BoxofficeInfo<MovieInfoObject>(apiType: apiType, model: NetworkModel(session: session))
    }
}
