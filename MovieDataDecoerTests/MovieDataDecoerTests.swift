//
//  MovieDataDecoerTests.swift
//  MovieDataDecoerTests
//
//  Created by Morgan, Toy on 11/27/23.
//

import XCTest
@testable import BoxOffice

final class MovieDataDecoerTests: XCTestCase {
    var sut: BoxOfficeData!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = try MovieDataDecoder.decodeAssetData(assetName: "box_office_sample", decoder: JSONDecoder())
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func testExample() {
    
    }
}
