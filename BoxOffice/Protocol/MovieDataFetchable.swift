//
//  APIProtocol.swift
//  BoxOffice
//
//  Created by karen on 2023/07/26.
//

protocol MovieDataFetchable {
    func fetchMovieData(completion: @escaping (Result<[MovieInfo], Error>) -> ())
}
