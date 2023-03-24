//
//  KobisURLSession.swift
//  BoxOffice
//
//  Created by Muri, Rowan on 2023/03/22.
//

import Foundation

protocol DataTaskMakeable {
    func dataTask(with request: URLRequest, completionHandler: @escaping @Sendable (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
}

extension URLSession: DataTaskMakeable { }
