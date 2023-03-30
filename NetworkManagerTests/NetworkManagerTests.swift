//
//  NetworkManagerTests.swift
//  NetworkManagerTests
//
//  Created by Rhode, Rilla on 2023/03/23.
//

import XCTest
@testable import BoxOffice

final class NetworkManagerTests: XCTestCase {
    var sut: NetworkManager!
    
    override func setUpWithError() throws {
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [MockURLProtocolObject.self]
        let session = URLSession(configuration: configuration)
        
        sut = NetworkManager(session: session)
    }
    
    override func tearDownWithError() throws {
        sut = nil
    }
    
    func test_() {
        //given
        MockURLProtocolObject.requestHandler = { request in
            let data = StubBoxOffice().data
            let responses = HTTPURLResponse(url: request.url!, mimeType: "text", expectedContentLength: 500, textEncodingName: nil)
            
            return (responses, data)
        }
        
        
        //when
        
        //then
        
    }
}
