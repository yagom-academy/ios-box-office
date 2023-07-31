//
//  StubURLSession.swift
//  BoxOffice
//
//  Created by kyungmin, Erick on 2023/07/26.
//

import Foundation

struct DummyData {
    let data: Data?
    let response: URLResponse?
    let error: Error?
    var completionHandler: DataTaskCompletionHandler? = nil

    func completion() {
        completionHandler?(data, response, error)
    }
}

final class StubURLSession: URLSessionProtocol {
    var dummyData: DummyData?
    
    init(dummy: DummyData?) {
        self.dummyData = dummy
    }

    func dataTask(with url: URL, completionHandler: @escaping DataTaskCompletionHandler) -> URLSessionDataTask {
        return StubURLSessionDataTask(dummy: dummyData, completionHandler: completionHandler)
    }
}

final class StubURLSessionDataTask: URLSessionDataTask {
    var dummyData: DummyData?

    init(dummy: DummyData?, completionHandler: DataTaskCompletionHandler?) {
        self.dummyData = dummy
        self.dummyData?.completionHandler = completionHandler
    }

    override func resume() {
        DispatchQueue.global().async {
            Thread.sleep(forTimeInterval: 2)
            self.dummyData?.completion()
        }
    }
}
