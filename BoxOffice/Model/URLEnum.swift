//
//  URLEnum.swift
//  BoxOffice
//
//  Created by goat, songjun on 2023/03/22.
//

import Foundation

enum URLAddress {
    static let dailyBoxOfficeURL: String = "http://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=f5eef3421c602c6cb7ea224104795888&targetDt=20120101"
    
    static let movieDetailURL: String = "http://www.kobis.or.kr/kobisopenapi/webservice/rest/movie/searchMovieInfo.json?key=f5eef3421c602c6cb7ea224104795888&movieCd=20124079"
}
