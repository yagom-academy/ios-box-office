//
//  BoxOfficeTests.swift
//  BoxOfficeTests
//
//  Created by 리지, kokkilE on 2023/03/20.
//

import XCTest
@testable import BoxOffice
final class BoxOfficeTests: XCTestCase {
    var sut: BoxOffice!
    let jsonDecoder = JSONDecoder()
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        
        guard let dataAsset = NSDataAsset(name: "box_office_sample") else { return }
        do {
            sut = try jsonDecoder.decode(BoxOffice.self, from: dataAsset.data)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    override func tearDownWithError() throws {
        try super.tearDownWithError()

        sut = nil
    }
    
    func test_parsing한_movieList의개수는_10개이다() {
        // given
        let expectation = 10
        
        // when
        let result = sut.boxOfficeResult.boxOfficeList.count
        
        // then
        XCTAssertEqual(result, expectation)
    }
    
    func test_parsing결과_movie_rank1은_경관의피이다() {
        // given
        let expectation = "경관의 피"
        
        // when
        var result: String = ""
        sut.boxOfficeResult.boxOfficeList.forEach {
            if $0.rank == "1" {
                result = $0.name
                print("결과는\(result)")
            }
        }
        
        // then
        XCTAssertEqual(result, expectation)
    }
}
