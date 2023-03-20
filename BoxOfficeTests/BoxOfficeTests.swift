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
    var fileName = "box_office_sample"
    
    override func tearDownWithError() throws {
        try super.tearDownWithError()

        sut = nil
    }
    
    func parseJSON(_ fileName: String) {
        guard let dataAsset = NSDataAsset(name: fileName) else { return }
        
        do {
            let jsonDecoder = JSONDecoder()
            sut = try jsonDecoder.decode(BoxOffice.self, from: dataAsset.data)
        } catch {
            sut = nil
            print(error.localizedDescription)
        }
    }
    
    func test_잘못된파일명으로_parseJSON호출시_sut는nil이다() {
        // given
        let wrongFileName = "wrongFileName"
        
        // when
        parseJSON(wrongFileName)
        
        // then
        XCTAssertNil(sut)
    }
    
    func test_올바른파일명으로_parseJSON호출시_sut는nil이아니다() {
        // when
        parseJSON(fileName)
        
        // then
        XCTAssertNotNil(sut)
    }
    
    func test_parsing한_movieList의개수는_10개이다() {
        // given
        parseJSON(fileName)
        let expectation = 10
        
        // when
        let result = sut.boxOfficeResult.boxOfficeList.count
        
        // then
        XCTAssertEqual(result, expectation)
    }
    
    func test_parsing한_movie_rank1인_영화이름은_경관의피이다() {
        // given
        parseJSON(fileName)
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
    
    func test_parsing한_movieList의_첫번째movie의프로퍼티는_원본데이터와같다() {
        // given
        parseJSON(fileName)
        let expectation = ["1", "1", "0", "NEW", "20199882", "경관의 피", "2022-01-05", "584559330", "34.2", "584559330", "100", "631402330", "64050", "64050", "100", "69228", "1171", "4416"]
        
        // when
        var result: [String] = []
        result.append(sut.boxOfficeResult.boxOfficeList[0].order)
        result.append(sut.boxOfficeResult.boxOfficeList[0].rank)
        result.append(sut.boxOfficeResult.boxOfficeList[0].rankVariance)
        result.append(sut.boxOfficeResult.boxOfficeList[0].rankOldAndNew)
        result.append(sut.boxOfficeResult.boxOfficeList[0].code)
        result.append(sut.boxOfficeResult.boxOfficeList[0].name)
        result.append(sut.boxOfficeResult.boxOfficeList[0].openDate)
        result.append(sut.boxOfficeResult.boxOfficeList[0].salesAmount)
        result.append(sut.boxOfficeResult.boxOfficeList[0].salesShare)
        result.append(sut.boxOfficeResult.boxOfficeList[0].salesVariance)
        result.append(sut.boxOfficeResult.boxOfficeList[0].salesChange)
        result.append(sut.boxOfficeResult.boxOfficeList[0].salesAccumulation)
        result.append(sut.boxOfficeResult.boxOfficeList[0].audienceCount)
        result.append(sut.boxOfficeResult.boxOfficeList[0].audienceVariance)
        result.append(sut.boxOfficeResult.boxOfficeList[0].audienceChange)
        result.append(sut.boxOfficeResult.boxOfficeList[0].audienceAccumulation)
        result.append(sut.boxOfficeResult.boxOfficeList[0].screenCount)
        result.append(sut.boxOfficeResult.boxOfficeList[0].showCount)
        
        // then
        XCTAssertEqual(result, expectation)
    }
    
    func test_parsing한_movieList의_rnum을순서대로출력시_원본데이터순서와같다() {
        // given
        parseJSON(fileName)
        let expectation = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10"]
        
        // when
        var result: [String] = []
        sut.boxOfficeResult.boxOfficeList.forEach {
            result.append($0.order)
        }

        // then
        XCTAssertEqual(result, expectation)
    }
}
