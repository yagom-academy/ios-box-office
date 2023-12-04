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
            XCTFail()
            return
        }
        
        //when, then
        do {
            let jsonData = try Decoder().parse(data: data, type: Movie.self)
            XCTAssertEqual(movie, jsonData)
        } catch  {
            XCTFail()
        }
    }
}


