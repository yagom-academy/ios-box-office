//
//  URLSessionProtocol.swift
//  BoxOffice
//
//  Created by kaki, harry on 2023/03/23.
//

import Foundation

protocol URLSessionProtocol {
    func dataTask(with url: URL, completionHandler: @escaping @Sendable (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
}

extension URLSession: URLSessionProtocol { }
