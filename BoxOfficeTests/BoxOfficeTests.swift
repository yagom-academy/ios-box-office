//
//  BoxOfficeTests.swift
//  BoxOfficeTests
//
//  Created by Zion, Hemg on 2023/07/24.
//

import XCTest
@testable import BoxOffice

extension MovieInformation: Equatable {
    public static func == (lhs: MovieInformation, rhs: MovieInformation) -> Bool {
        return lhs.movieCode == rhs.movieCode
    }
}

final class BoxOfficeTests: XCTestCase {
    
    private var sut: BoxOfficeResult.DailyBoxOffice!
    
    override func setUpWithError() throws {
        let decoder = JSONDecoder()
        let asset = NSDataAsset(name: "box_office_sample")!
        let boxOfficeResult = try! decoder.decode(BoxOfficeResult.self, from: asset.data)
        
        sut = boxOfficeResult.daily
    }
    
    override func tearDownWithError() throws {
        sut = nil
    }
    
    func test_디코딩결과값_확인() {
        //given
        let firstExpectation = MovieInformation(number: "1",
                                                rank: "1",
                                                rankInten: "0",
                                                rankOldAndNew: "NEW",
                                                movieCode: "20199882",
                                                movieName: "경관의 피",
                                                openDate: "2022-01-05",
                                                salesAmount: "584559330",
                                                salesShare: "34.2",
                                                salesInten: "584559330",
                                                salesChange: "100",
                                                salesAccumulate: "631402330",
                                                audienceCount: "64050",
                                                audienceInten: "64050",
                                                audienceChange: "100",
                                                audienceAccumulate: "69228",
                                                screenCount: "1171",
                                                showCount: "4416")
        
        let lastExpectation = MovieInformation(number: "10",
                                               rank: "10",
                                               rankInten: "-3",
                                               rankOldAndNew: "OLD",
                                               movieCode: "20210864",
                                               movieName: "엔칸토: 마법의 세계",
                                               openDate: "2021-11-24",
                                               salesAmount: "2290000",
                                               salesShare: "0.1",
                                               salesInten: "-7180050",
                                               salesChange: "-75.8",
                                               salesAccumulate: "5964273080",
                                               audienceCount: "291",
                                               audienceInten: "-765",
                                               audienceChange: "-72.4",
                                               audienceAccumulate: "628878",
                                               screenCount: "23",
                                               showCount: "24")
        
        //when
        let first = sut.dailyBoxOfficeList.first
        let last = sut.dailyBoxOfficeList.last
        
        //then
        XCTAssertEqual(firstExpectation, first)
        XCTAssertEqual(lastExpectation, last)
    }
}
