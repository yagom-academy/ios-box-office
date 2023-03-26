//
//  BoxOfficeTests.swift
//  BoxOfficeTests
//
//  Created by Jinah Park on 2023/03/20.
//

import XCTest
@testable import BoxOffice

final class BoxOfficeTests: XCTestCase {
    var sut: DecodeManager!
    
    override func setUpWithError() throws {
        sut = DecodeManager()
    }

    override func tearDownWithError() throws {
        sut = nil
    }
    
    func test_디코딩시_존재하는파일이름을넘겨주면_result는success이다() {
        //given
        let fileName = "box_office_sample"
        var success: Bool
        
        //when
        let result = sut.decodeJSON(fileName: fileName, type: BoxOffice.self)
        
        switch result {
        case .success(_):
            success = true
        case .failure(_):
            success = false
        }
        //then
        XCTAssertTrue(success)
    }
    
    
    func test_디코딩시_존재하지않는파일이름을넘겨주면_result는failure이다() {
        //given
        let fileName = "box_office"
        var success: Bool
        
        //when
        let result = sut.decodeJSON(fileName: fileName, type: BoxOffice.self)
        
        switch result {
        case .success(_):
            success = true
        case .failure(_):
            success = false
        }
        //then
        XCTAssertFalse(success)
    }
    
    func test_디코딩시_샘플JSON이주어졌을때_BoxOffice는nil이아니다() {
        //given
        let fileName = "box_office_sample"
            
        //when
        let result = sut.decodeJSON(fileName: fileName, type: BoxOffice.self)
        var decodedFile: BoxOffice?
        
        switch result {
        case .success(let resultFile):
            decodedFile = resultFile
        case .failure(_):
            decodedFile = nil
        }
        
        //then
        XCTAssertNotNil(decodedFile)
    }
    
    func test_디코딩시_샘플JSON이주어졌을때_BoxOfficeResult는nil이아니다() {
        //given
        let fileName = "box_office_sample"
            
        //when
        let decodedResult = sut.decodeJSON(fileName: fileName, type: BoxOffice.self)
        var decodedFile: BoxOffice?
        
        switch decodedResult {
        case .success(let resultFile):
            decodedFile = resultFile
        case .failure(_):
            decodedFile = nil
        }
        
        let result = decodedFile?.boxOfficeResult
        
        //then
        XCTAssertNotNil(result)
    }
    
    func test_디코딩시_샘플JSON이주어졌을때_DailyBoxOfficeList는nil이아니다() {
        //given
        let fileName = "box_office_sample"
            
        //when
        let decodedResult = sut.decodeJSON(fileName: fileName, type: BoxOffice.self)
        var decodedFile: BoxOffice?
        
        switch decodedResult {
        case .success(let resultFile):
            decodedFile = resultFile
        case .failure(_):
            decodedFile = nil
        }
        
        let result = decodedFile?.boxOfficeResult.dailyBoxOfficeList
        
        //then
        XCTAssertNotNil(result)
    }
    
    func test_디코딩시_샘플JSON이주어졌을때_dailyBoxOfficeList는10개의요소를가진다() {
        //given
        let fileName = "box_office_sample"
            
        //when
        let decodedResult = sut.decodeJSON(fileName: fileName, type: BoxOffice.self)
        var decodedFile: BoxOffice?
        
        switch decodedResult {
        case .success(let resultFile):
            decodedFile = resultFile
        case .failure(_):
            decodedFile = nil
        }
        
        let result = decodedFile?.boxOfficeResult.dailyBoxOfficeList.count
        let expectedResult = 10
        
        //then
        XCTAssertEqual(result, expectedResult)
    }
    
    func test_디코딩시_첫번째인덱스의sequence의value가Int형태를가진다() {
        //given
        let fileName = "box_office_sample"
            
        //when
        let decodedResult = sut.decodeJSON(fileName: fileName, type: BoxOffice.self)
        var decodedFile: BoxOffice?
        
        switch decodedResult {
        case .success(let resultFile):
            decodedFile = resultFile
        case .failure(_):
            decodedFile = nil
        }
        guard let number = decodedFile?.boxOfficeResult.dailyBoxOfficeList[0].sequence else {
            return
        }
        let result = Int(number)
        
        //then
        XCTAssertNotNil(result)
        
       
    }
    
    func test_디코딩시_첫번째인덱스의salesShare의value가Double형태를가진다() {
        //given
        let fileName = "box_office_sample"
            
        //when
        let decodedResult = sut.decodeJSON(fileName: fileName, type: BoxOffice.self)
        var decodedFile: BoxOffice?
        
        switch decodedResult {
        case .success(let resultFile):
            decodedFile = resultFile
        case .failure(_):
            decodedFile = nil
        }
        
        guard let number = decodedFile?.boxOfficeResult.dailyBoxOfficeList[0].salesShare else {
            return
        }
        
        let result = Double(number)
        
        //then
        XCTAssertNotNil(result)
    }
    
    func test_dailyBoxOfficeList의_rank가1위인영화는_경관의피이다() {
        //given
        let fileName = "box_office_sample"
            
        //when
        let decodedResult = sut.decodeJSON(fileName: fileName, type: BoxOffice.self)
        var decodedFile: BoxOffice?
        
        switch decodedResult {
        case .success(let resultFile):
            decodedFile = resultFile
        case .failure(_):
            decodedFile = nil
        }
        
        let expectedResult = "경관의 피"
        let resultBoxOfficeList = decodedFile?.boxOfficeResult.dailyBoxOfficeList.filter { boxOffice in
            boxOffice.rank == "1"
        }
        
        let result = resultBoxOfficeList?.first
        
        //then
        XCTAssertEqual(result?.movieName, expectedResult)
    }

}
