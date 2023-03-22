//
//  Requestable.swift
//  BoxOffice
//
//  Created by 리지, kokkilE on 2023/03/21.
//

import Foundation

protocol URLAcceptable {
    var url: URL? { get }
    var urlComponents: URLComponents? { get set }
    var key: URLQueryItem { get }
}
