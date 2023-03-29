//
//  URLSessionDataTaskProtocol.swift
//  BoxOffice
//
//  Created by Christy, Hyemory on 2023/03/23.
//

import Foundation

protocol URLSessionDataTaskProtocol {
    func resume()
}

extension URLSessionDataTask: URLSessionDataTaskProtocol {}
