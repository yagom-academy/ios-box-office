//
//  MovieTests.swift
//  MovieTests
//
//  Created by kaki, harry on 2023/03/21.
//

import XCTest
@testable import BoxOffice

final class MovieTests: XCTestCase {
    private var sut: Movie!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        sut = nil
    }
    
    func test_jsonDecoder_decode_성공() {
        // when
        let jsonDecoder = JSONDecoder()
        guard let dataAsset = NSDataAsset(name: "Movie") else {
            XCTFail("DataAsset Error")
            return
        }
        // then
        XCTAssertNoThrow(try jsonDecoder.decode(Movie.self, from: dataAsset.data))
    }
}
