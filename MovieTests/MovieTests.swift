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
        
        guard let data = TestMovieJsonData.json.data(using: .utf8) else {
            return XCTFail()
        }
        
        //when, then
        do {
            let jsonData = try JSONDecoder().decode(Movie.self, from: data)
            XCTAssertEqual(movie, jsonData)
        } catch  {
            XCTFail()
        }
    }
}


