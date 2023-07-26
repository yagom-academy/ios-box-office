//
//  APIProtocol.swift
//  BoxOffice
//
//  Created by karen on 2023/07/26.
//

protocol APIProtocol {
    func callAPIServer(completion: @escaping (Result<[MovieInfo], Error>) -> ())
}
