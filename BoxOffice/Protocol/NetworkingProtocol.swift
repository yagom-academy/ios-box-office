//
//  APIProtocol.swift
//  BoxOffice
//
//  Created by karen on 2023/07/26.
//
import Foundation

protocol NetworkingProtocol {
    init(session: URLSession)

    func getRequest(url: URL, completion: @escaping (Result<Data, BoxOfficeError>) -> Void) -> URLSessionDataTask
}
