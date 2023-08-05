//
//  URLSessionProtocol.swift
//  BoxOffice
//
//  Created by kyungmin, Erick on 2023/07/26.
//

import Foundation

typealias DataTaskCompletionHandler = (Data?, URLResponse?, Error?) -> Void

protocol URLSessionProtocol {
    func dataTask(with urlRequest: URLRequest,  completionHandler: @escaping DataTaskCompletionHandler) -> URLSessionDataTask
}
