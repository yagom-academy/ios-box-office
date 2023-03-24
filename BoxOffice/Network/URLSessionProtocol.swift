//
//  URLSessionProtocol.swift
//  BoxOffice
//
//  Created by vetto, brody on 23/03/22.
//

import Foundation

protocol URLSessionProtocol {
    func dataTask(
        for request: URLRequest,
        completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void
    ) -> URLSessionDataTaskProtocol
}

extension URLSession: URLSessionProtocol {
    func dataTask(
        for request: URLRequest,
        completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void
    ) -> URLSessionDataTaskProtocol {
        return dataTask(with: url, completionHandler: completionHandler) as URLSessionDataTask
    }
}
