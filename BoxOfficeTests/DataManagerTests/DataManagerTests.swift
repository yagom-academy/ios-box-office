//
//  DataManagerTests.swift
//  DataManagerTests
//
//  Created by Muri, Rowan on 2023/03/20.
//

import XCTest
@testable import BoxOffice

final class DataManagerTests: XCTestCase {
    var sut: DataManager!
    let sampleData = NSDataAsset(name: "DailyBoxOffice")!.data
    
    override func setUpWithError() throws {
        sut = DataManager()
    }
    
    override func tearDownWithError() throws {
        sut = nil
    }
    
    func test_startLoadDailyBoxOfficeData호출_실패시_() {
        // given
        
        
        // when
        
        
        // then
        

    }
    
    func test_startLoadDailyBoxOfficeData호출_성공시_예상한boxOfficType과showRange와_일치한다() {
        // given
        let expectedBoxOfficeType = ""
    
        
        // when
        
        
        // then
        

    }
}
