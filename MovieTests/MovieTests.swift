//
//  MovieTests.swift
//  MovieTests
//
//  Created by jyubong, kiseok
//

import XCTest
@testable import BoxOffice

final class MovieTests: XCTestCase {

    func test_init을통해만든Movie타입과Json데이터를_비교했을때_서로같다() {
        //given
        let movie = DummyMovie().movie
        let data = TestMovieJsonData.json.data(using: .utf8)!
        let jsonData = try! JSONDecoder().decode(Movie.self, from: data)
        
        //when, then
        XCTAssertEqual(movie, jsonData)
    }
}


