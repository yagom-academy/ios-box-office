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
    
    let dailyBoxOfficeURL: String = "http://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=f5eef3421c602c6cb7ea224104795888&targetDt=20120101"
    
    let movieDetailURL: String = "http://www.kobis.or.kr/kobisopenapi/webservice/rest/movie/searchMovieInfo.json?key=f5eef3421c602c6cb7ea224104795888&movieCd=20124079"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        boxOfficeAPI.delegate = self
        
        boxOfficeAPI.loadBoxOfficeAPI(urlAddress: dailyBoxOfficeURL, parserType: dailyBoxOfficeParser)
        test()
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
