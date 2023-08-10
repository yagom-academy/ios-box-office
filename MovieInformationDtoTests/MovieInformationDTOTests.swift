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
                                  movieCode: "1234",
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
    
    func test_OldAndNew가_New로되있을시_신작으로표시되는지_확인() {
        //given
        let expectiontation = addAttributeString(text: "신작", keyword: "신작", color: .red)
        
        //when
        let result = sut.conventedRankIntenSybolAndText()
        
        //then
        XCTAssertEqual(expectiontation, result)
    }
    
    func test_OldAndNew가_OLD로되있을시_상승rank로_표시되는지_확인() {
        //given
        sut = MovieInformationDTO(rank: "1",
                                  rankInten: "1",
                                  oldAndNew: "OLD",
                                  movieName: "밀수",
                                  movieCode: "1234",
                                  audienceCount: "450000",
                                  audienceAccumulate: "6000000")
        
        let expectiontation = addAttributeString(text: "▲\(sut.rankInten)", keyword: "▲", color: .red)
        
        //when
        let result = sut.conventedRankIntenSybolAndText()
        
        //then
        XCTAssertEqual(expectiontation, result)
    }
    
    func test_OldAndNew가_OLD로되있을시_하락rank로_표시되는지_확인() {
        //given
        sut = MovieInformationDTO(rank: "10",
                                  rankInten: "-3",
                                  oldAndNew: "OLD",
                                  movieName: "밀수",
                                  movieCode: "1234",
                                  audienceCount: "450000",
                                  audienceAccumulate: "6000000")
        
        let decreaseRank = sut.rankInten.replacingOccurrences(of: "-", with: "")
        let expectiontation = addAttributeString(text: "▼\(decreaseRank)", keyword: "▼", color: .blue)
        
        //when
        let result = sut.conventedRankIntenSybolAndText()
        
        //then
        XCTAssertEqual(expectiontation, result)
    }
    
    func test_OldAndNew가_OLD로되있을시_동일Rank로_표시되는지_확인() {
        //given
        sut = MovieInformationDTO(rank: "10",
                                  rankInten: "0",
                                  oldAndNew: "OLD",
                                  movieName: "밀수",
                                  movieCode: "1234",
                                  audienceCount: "450000",
                                  audienceAccumulate: "6000000")
        
        let expectiontation = addAttributeString(text: "-", keyword: "-", color: .black)
        
        //when
        let result = sut.conventedRankIntenSybolAndText()
        
        //then
        XCTAssertEqual(expectiontation, result)
    }
    
    private func addAttributeString(text: String, keyword: String, color: UIColor) -> NSMutableAttributedString {
        let attributeString = NSMutableAttributedString(string: text)
        
        attributeString.addAttribute(.foregroundColor, value: color , range: (text as NSString).range(of: keyword))
        return attributeString
    }
}
