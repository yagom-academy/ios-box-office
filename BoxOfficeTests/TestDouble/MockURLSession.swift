//
//  URLSession.swift
//  BoxOfficeTests
//
//  Created by Hisop on 2023/12/01.
//

import Foundation
@testable import BoxOffice

class MockURLSession: URLSessionProtocol {
    func dataTask(with url: URL, completionHandler: @escaping @Sendable (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        <#code#>
    }
    
    
}

