//
//  URLSessionProtocol.swift
//  BoxofficeInfoTests
//
//  Created by Andrew, 레옹아범 on 2023/03/22.
//

import Foundation

protocol URLSessionProtocol {
    func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
}
