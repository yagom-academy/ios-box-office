//
//  URLRequestGenerator.swift
//  BoxOffice
//
//  Created by Muri, Rowan on 2023/03/28.
//

import Foundation

protocol URLRequestGenerator {
    func request(for api: API) -> URLRequest?
}
