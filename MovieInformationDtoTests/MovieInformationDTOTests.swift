//
//  MovieInformationDtoTests.swift
//  MovieInformationDtoTests
//
//  Created by Zion, Hemg on 2023/08/07.
//

import XCTest
@testable import BoxOffice

final class MovieInformationDTOTests: XCTestCase {
    private var sut: MovieInformationDTO!

    override func setUpWithError() throws {
        sut = MovieInformationDTO(rank: "1",
                                  rankInten: "1",
                                  oldAndNew: "NEW",
                                  movieName: "밀수",
                                  audienceCount: "450000",
                                  audienceAccumulate: "6000000")
    }
    
    override func tearDownWithError() throws {
        sut = nil
    }
    
    func test_DecimalCount가_converted함수에적용이되는지_확인() {
        //given
        let audienceCountExpectation = "450,000"
        let audienceAccumulateExpectation = "6,000,000"
        
        //when
        let audienceCountResult = sut.convertDecimalFormattedString(text: sut.audienceCount)
        let audienceAccumulateResult = sut.convertDecimalFormattedString(text: sut.audienceAccumulate)
        
        //then
        XCTAssertEqual(audienceCountExpectation, audienceCountResult)
        XCTAssertEqual(audienceAccumulateExpectation, audienceAccumulateResult)
    }
}
