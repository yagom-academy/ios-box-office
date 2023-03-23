//
//  URLSessionDataTaskProtocol.swift
//  BoxOffice
//
//  Created by kaki, harry on 2023/03/23.
//

import Foundation

protocol URLSessionDataTaskProtocol {
    func resume()
}

extension URLSessionDataTask: URLSessionDataTaskProtocol {}
