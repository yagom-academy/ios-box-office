//
//  BoxofficeInfoTests.swift
//  BoxofficeInfoTests
//
//  Created by 강민수 on 2023/03/28.
//

import XCTest
@testable import BoxOffice

final class MockBoxofficeInfo: NetworkingProtocol {
    
    
    func search(url: URL, completion: @escaping (Result<Data, BoxOffice.BoxofficeError>) -> Void) -> URLSessionDataTask {
        <#code#>
    }
    
    
}

final class BoxofficeInfoTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
}
