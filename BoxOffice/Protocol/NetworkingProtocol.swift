//
//  NetworkingProtocol.swift
//  BoxOffice
//
//  Created by Andrew on 2023/03/28.
//

import Foundation

protocol NetworkingProtocol {
    func search(url: URL, completion: @escaping (Result<Data, BoxofficeError>) -> Void) -> URLSessionDataTask
    init(session: URLSession)
}
