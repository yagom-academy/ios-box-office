//
//  Extension.swift
//  BoxOffice
//
//  Created by Hisop on 2023/12/12.
//

import Foundation

protocol URLSessionProtocol {
    func dataTask(with url: URL,
                  completionHandler: @escaping @Sendable (Data?, URLResponse?, Error?) -> Void)
    -> URLSessionDataTask
}

extension URLSession: URLSessionProtocol { }
