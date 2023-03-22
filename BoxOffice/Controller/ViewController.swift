//
//  ViewController.swift
//  BoxOffice
//
//  Created by goat, songjun on 13/01/23.
//

import UIKit

final class ViewController: UIViewController {
    private var parsedMovieDetail: MovieDetail?
    private var parsedDailyBoxOffice: DailyBoxOffice?
    
    private let dailyBoxOfficeParser = Parser<DailyBoxOffice>()
    private let movieDetailParser = Parser<MovieDetail>()
    
    private var boxOfficeAPI = BoxOfficeAPI()

    override func viewDidLoad() {
        super.viewDidLoad()
        boxOfficeAPI.delegate = self
        
        boxOfficeAPI.loadBoxOfficeAPI(urlAddress: URLAddress.dailyBoxOfficeURL, parserType: dailyBoxOfficeParser)
        test()
        print()
    }
    
    func test() {
        Thread.sleep(forTimeInterval: 1)
        print(parsedDailyBoxOffice?.boxOfficeResult.boxOfficeType)
    }
    
    
}

extension ViewController: BoxOfficeAPIDelegate {
    func fetchAPIData<T>(data: T) where T : Decodable {
    
        switch data {
        case is MovieDetail:
            parsedMovieDetail = data as? MovieDetail
        case is DailyBoxOffice:
            parsedDailyBoxOffice = data as? DailyBoxOffice
        default:
            return
        }
    }
}
