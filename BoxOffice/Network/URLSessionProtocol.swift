//
//  URLSessionProtocol.swift
//  BoxOffice
//
//  Created by Rhode, Rilla on 2023/03/21.
//

import Foundation

protocol URLSessionProtocol {
    associatedtype T: URLSessionDataTaskProtocol
    
    func dataTask(with request: URLRequest, completionHandler: @escaping(Data?, URLResponse?, Error?) -> Void) -> T
}


