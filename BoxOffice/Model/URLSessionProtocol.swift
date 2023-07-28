//
//  URLSessionProtocol.swift
//  BoxOffice
//
//  Created by Yetti, Maxhyunm on 2023/07/28.
//

import Foundation

typealias CompletionHandler = (Data?, URLResponse?, Error?) -> Void

protocol URLSessionProtocol {
    func dataTask(with url: URL, completionHandler: @escaping CompletionHandler) -> URLSessionDataTask
}


extension URLSession: URLSessionProtocol {}
