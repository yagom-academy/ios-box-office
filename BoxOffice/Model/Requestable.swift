//
//  API.swift
//  BoxOffice
//
//  Created by vetto, brody on 23/03/24.
//

import Foundation

protocol Requestable {
    var urlComponents: URLComponents? { get }
    var baseURL: String { get }
    var path: String { get }
    var method: BoxOfficeHttpMethod { get }
}
