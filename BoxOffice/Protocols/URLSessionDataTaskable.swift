//
//  URLSessionDataTaskable.swift
//  BoxOffice
//
//  Created by Seoyeon Hong on 2023/03/22.
//

import Foundation

protocol URLSessionDataTaskable {
    func resume()
}

extension URLSessionDataTask: URLSessionDataTaskable {}

