//
//  BoxOfficeTests.swift
//  BoxOfficeTests
//
//  Created by Zion, Hemg on 2023/07/24.
//

import XCTest
@testable import BoxOffice

final class BoxOfficeTests: XCTestCase {
    
    var sut: BoxOfficeResult!
    
    override func setUpWithError() throws {
        let decoder = JSONDecoder()
        
        guard let asset = NSDataAsset(name: "box_office_sample") else {
            return
        }
        
        guard let sut = try? decoder.decode(BoxOfficeResult.self, from: asset.data) else {
            return
        }
        
//        self.sut = sut
    }

    override func tearDownWithError() throws {
        sut = nil
    }
    
    func test_sut_값확인() {
        
    }
    
    
    
}
