//
//  MockURLSessionDataTask.swift
//  BoxOfficeTests
//
//  Created by Zion, Hemg on 2023/07/28.
//

import Foundation

final class MockURLSessionDataTask: URLSessionDataTask {
    let data: Data
    
    init(data: Data) {
        self.data = data
    }
    
    override func resume() {
        
    }
}
