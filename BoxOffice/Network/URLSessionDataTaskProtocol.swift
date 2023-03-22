//
//  URLSessionDataTaskProtocol.swift
//  BoxOffice
//
//  Created by vetto, brody on 23/03/22.
//

import Foundation

protocol URLSessionDataTaskProtocol {
    func resume()
}

extension URLSessionDataTask: URLSessionDataTaskProtocol {}
