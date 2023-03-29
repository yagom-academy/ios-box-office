//
//  API.swift
//  BoxOffice
//
//  Created by Muri, Rowan on 2023/03/24.
//

import Foundation

protocol API {
    var baseURL: String { get }
    var path: String { get }
    var queries: [String: String] { get set }
    var headers: [String: String] { get set }
    var sampleData: Data? { get }
    
    mutating func addQuery(name: String, value: String)
}

extension API {
    mutating func addQuery(name: String, value: String) {
        self.queries[name] = value
    }
}
