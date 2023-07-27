//
//  GetDataAPI.swift
//  BoxOffice
//
//  Created by karen on 2023/07/26.
//

final class MovieDataFetchable: APIProtocol {
    func callAPIServer(completion: @escaping (Result<[MovieInfo], Error>) -> ()) {}
}
