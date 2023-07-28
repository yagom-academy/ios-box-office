//
//  BoxOfficeTests.swift
//  BoxOfficeTests
//
//  Created by karen on 2023/07/26.
//

import XCTest

@testable import BoxOffice

final class BoxOfficeTests: XCTestCase {
    var dataManager: DataManager!
    
    override func setUp() {
        super.setUp()
        dataManager = DataManager()
    }

    override func tearDownWithError() throws {
        super.tearDown()
        dataManager = nil
    }
    
    func test_decodeJSON메소드가_제대로_동작해서_반환된_배열의_count는_10이다() {
        // Given
        guard let decodedMovies = dataManager.decodeJSON() else { return }

        // When
        let result = 10

        // Then
        XCTAssertNotNil(decodedMovies)
        XCTAssertEqual(decodedMovies.count, result)
    }
    
    func test_decodeData메소드가_제대로_동작해서_디코딩된_데이터의_첫번째_영화_이름은_경관의_피이다() {
        // Given
        guard let itemsData = dataManager.loadData(named: DataNamespace.item) else { return }

        // When
        guard let decodedMovies: DailyBoxOffice = dataManager.decodeData(DailyBoxOffice.self, from: itemsData) else { return }
        // Then
        XCTAssertNotNil(decodedMovies)
        XCTAssertEqual(decodedMovies.boxOfficeResult.movies[0].name, "경관의 피")
    }
    
    func test_decodeData메소드가_제대로_동작해서_첫번째_영화의_rank_값은_1이다()
    {
        // Given
        guard let itemsData = dataManager.loadData(named: DataNamespace.item) else { return }

        // When
        guard let decodedMovies: DailyBoxOffice = dataManager.decodeData(DailyBoxOffice.self, from: itemsData) else { return }

        // Then
        XCTAssertEqual(decodedMovies.boxOfficeResult.movies[0].rank, "1")
    }

    func test_LoadData메소드가_올바른_이름의_파일을_로드하여_로드된_데이터가_Nil이_아니다() {
        // Given
        let name = DataNamespace.item
        
        // When
        let loadedData = dataManager.loadData(named: name)
        
        // Then
        XCTAssertNotNil(loadedData)
    }
}

