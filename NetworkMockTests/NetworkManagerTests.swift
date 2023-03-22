//
//  NetworkManagerTests.swift
//  BoxOffice
//
//  Created by vetto, brody on 23/03/22.
//

import XCTest
@testable import BoxOffice

final class NetworkMockTests: XCTestCase {
    
    var url: String!
    var data: Data!
    
    override func setUpWithError() throws {
        url = "https://www.kobis.or.kr/"
        data = JsonLoader.loadJsonAsset(name: "box_office_sample")
    }

    override func tearDownWithError() throws {
        url = nil
        data = nil
    }
    
    func test_fetchData호출시_Data가_있고_statusCode가_200일때() {
        //given
        
        //when
        
        // then
    }
}
