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
        sut = NetworkManager(session: URLSession())
    }

    override func tearDownWithError() throws {
        sut = nil
    }
    
    func test_() {
      
    }
}
