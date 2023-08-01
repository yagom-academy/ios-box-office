//
//  URLSessionProtocol.swift
//  BoxOffice
//
//  Created by Idinaloq, MARY on 2023/08/01.
//

import Foundation

protocol URLSessionProtocol {
    func dataTask(with url: URL, completionHandler: @escaping @Sendable (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
}
