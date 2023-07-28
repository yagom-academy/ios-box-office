//
//  URLSessionProtocol.swift
//  BoxOffice
//
//  Created by Zion, Hemg on 2023/07/28.
//

import Foundation

protocol URLSessionProtocol {
    func dataTask(with url: URL, completionHandler: @escaping @Sendable (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
}
