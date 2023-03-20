//
//  BoxOfficeTests.swift
//  BoxOfficeTests
//
//  Created by Seoyeon Hong on 2023/03/20.
//

import XCTest
@testable import BoxOffice

final class BoxOfficeTests: XCTestCase {
    
    private var decoder: JSONDecoder?
    
    override func setUpWithError() throws {
      try super.setUpWithError()
      decoder = JSONDecoder()
    }
    
    override func tearDownWithError() throws {
      try super.tearDownWithError()
      decoder = nil
    }
    
    func testDecode_IfBoxOfficeDataProvide_NoThrowError() {
        // given when then
        if let path = Bundle.main.path(forResource: "box_office_sample", ofType: "json"),
           let data = try? Data(contentsOf: URL(fileURLWithPath: path)) {
            XCTAssertNoThrow(try decoder?.decode(BoxOfficItem.self, from: data))
        }
    }
    
}
