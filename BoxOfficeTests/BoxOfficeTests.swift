//
//  BoxOfficeTests.swift
//  BoxOfficeTests
//
//  Created by karen on 2023/07/26.
//

import XCTest

@testable import BoxOffice

final class TestMovieDataAPI: MovieDataFetchable {
    var model:[MovieInfo] = []

    func fetchMovieData(completion: @escaping (Result<[MovieInfo], Error>) -> ()) {
        completion(.success(model))
    }
}

struct TestDataManager: DataManaging {
    private let decoder: JSONDecoder = JSONDecoder()

    func decodeJSON() -> [MovieInfo]? {
        guard let itemsData = loadData(named: DataNamespace.item),
              let decodedItems = decodeData(DailyBoxOffice.self, from: itemsData)
        else { return nil }
        
        return decodedItems.boxOfficeResult.movies
    }

    func loadData(named name: String) -> Data? {
        return NSDataAsset(name: name)?.data
    }

    func decodeData<MovieData: Decodable>(_ type: MovieData.Type, from data: Data) -> MovieData? {
        return try? decoder.decode(type, from: data)
    }
}

final class BoxOfficeTests: XCTestCase {
    var viewController: ViewController!
    var testClass: TestMovieDataAPI!
    var testData: TestDataManager!

    override func setUp() {
        super.setUp()
        viewController = (UIStoryboard(name: "Main", bundle: .main).instantiateViewController(withIdentifier: "main") as! ViewController)
        testClass = TestMovieDataAPI()
        viewController.apiProtocol = testClass
        testData = TestDataManager()
    }

    func test_API서버와의_통신으로_가져온_데이터가_5초안에_불러오고_Decoding이_잘되었는가() {
        // given
        guard let model = testData.decodeJSON() else { return }
        let expectation = XCTestExpectation(description: "wait")
        testClass.model = model
        
        let result = "경관의 피"
        
        // when
        viewController.requestAPI { result in
            switch result {
            case .success(let model):
                print("성공: \(model)")
                expectation.fulfill()
            case .failure(let error):
                print("실패: \(error.localizedDescription)")
            }
        }
        wait(for: [expectation], timeout: 5.0)
        
        // then
        XCTAssertEqual(result, model[0].name)
    }
}

