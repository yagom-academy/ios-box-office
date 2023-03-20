//
//  BoxOfficeTests.swift
//  BoxOfficeTests
//
//  Created by Harry on 2023/03/20.
//

import XCTest
@testable import BoxOffice

final class BoxOfficeTests: XCTestCase {
    private var sut: BoxOffice!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        sut = nil
    }
    
    func test_jsonDecoder_decode_성공() throws {
        let jsonDecoder = JSONDecoder()
        guard let dataAsset = NSDataAsset(name: "BoxOffice") else { return }
        
        do {
            sut = try jsonDecoder.decode(BoxOffice.self, from: dataAsset.data)
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
}
