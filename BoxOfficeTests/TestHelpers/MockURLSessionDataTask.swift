//
//  MockURLSessionDataTask.swift
//  BoxOfficeTests
//
//  Created by Seoyeon Hong on 2023/03/22.
//

import Foundation
@testable import BoxOffice

class MockURLSessionDataTask: URLSessionDataTaskable {
    
    private let handler: () -> Void
    
    init(handler: @escaping () -> Void) {
        self.handler = handler
    }
    
    func resume() {
        handler()
    }
    
}
