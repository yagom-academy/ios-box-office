//
//  DataManagerTests.swift
//  DataManagerTests
//
//  Created by Muri, Rowan on 2023/03/20.
//

import XCTest
@testable import BoxOffice

final class DataManagerTests: XCTestCase {
    var sut: DataManager!
    
    override func setUpWithError() throws {
        sut = DataManager()
    }
    
    override func tearDownWithError() throws {
        sut = nil
    }
}
