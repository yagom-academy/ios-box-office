//
//  GetDataAPI.swift
//  BoxOffice
//
//  Created by karen on 2023/07/26.
//

final class MovieDataAPI: MovieDataFetchable {
    func fetchMovieData(completion: @escaping (Result<[MovieInfo], Error>) -> ()) {}
}
