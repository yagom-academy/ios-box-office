//
//  SearchedMovieImageTests.swift
//  BoxOffice
//
//  Created by vetto, brody on 23/03/30.
//

import XCTest
@testable import BoxOffice

final class SearchedImageDTOTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }
    
    func test_DaumAPI의_query로_영화이름을_검색했을때_SearchedMovieImageDTO모델로_정상적으로_디코딩된다() {
        // given
        let expectation = expectation(description: "imageSearch")
        var resultImageURL: String?
        let boxOfficeProvider = BoxOfficeProvider<DaumAPI>()
        
        // when
        boxOfficeProvider.fetchData(.searchImage(movieName: "특송"),
                                    type: SearchedMovieImageDTO.self) { result in
            switch result {
            case .success(let data):
                print(data.documents[0])
                resultImageURL = data.documents[0].imageURL
                expectation.fulfill()
            case .failure:
                XCTFail()
            }
        }
        wait(for: [expectation], timeout: 2)
        
        // then
        XCTAssertNotNil(resultImageURL)
    }
}
