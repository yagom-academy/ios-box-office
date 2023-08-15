//
//  File.swift
//  BoxOffice
//
//  Created by redmango, Jusbug on 2023/07/31.
//

import Foundation

enum APIError: Error {
    case wrongURL
    case responseError
    case serverError
    case noData
}
