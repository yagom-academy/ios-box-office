//
//  URLSessionProtocol.swift
//  BoxOffice
//
//  Created by vetto, brody on 23/03/22.
//

import Foundation

protocol URLSessionProtocol {
    typealias DataTaskResult = @Sendable (Data?, URLResponse?, Error?) -> Void
    
    func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
}

extension URLSession: URLSessionProtocol {
    func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return dataTask(with: url, completionHandler: completionHandler)
    }
}
