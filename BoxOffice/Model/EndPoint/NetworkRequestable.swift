//
//  NetworkRequestable.swift
//  BoxOffice
//
//  Created by 리지, kokkilE on 2023/03/22.
//

import Foundation

protocol NetworkRequestable {
    var urlRequest: URLRequest? { get }
    var url: URL? { get }
}
