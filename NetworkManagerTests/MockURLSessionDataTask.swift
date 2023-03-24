//
//  MockURLSessionDataTask.swift
//  NetworkManagerTests
//
//  Created by Rhode, Rilla on 2023/03/23.
//

import Foundation

class MockURLSessionDataTask: URLSessionDataTask {
    
    var resumeDidCall: (() -> Void)?
    
    init(closure: @escaping () -> Void){
        self.resumeDidCall = closure
    }
    
    override func resume() {
        resumeDidCall?()
    }
}
