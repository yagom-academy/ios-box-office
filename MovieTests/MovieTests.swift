//
//  MovieTests.swift
//  MovieTests
//
//  Created by jyubong, kiseok
//

import XCTest
@testable import BoxOffice

final class MovieTests: XCTestCase {
    
    func test_init을통해만든Movie타입과Json데이터를_비교했을때_서로같다() throws {
        //given
        let movie = DummyMovie().movie
        
        let data = try XCTUnwrap(TestMovieJsonData.json.data(using: .utf8))
        
        //when, then
        do {
            let jsonData = try Decoder().parse(data: data, type: Movie.self)
            XCTAssertEqual(movie, jsonData)
        } catch  {
            XCTFail()
        }
    }
}


