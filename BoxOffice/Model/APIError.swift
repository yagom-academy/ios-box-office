//
//  File.swift
//  BoxOffice
//
//  Created by 박종화 on 2023/07/31.
//

import Foundation

enum APIError: Error {
    case wrongURL
    case responseError
    case serverError
    case noData
}
