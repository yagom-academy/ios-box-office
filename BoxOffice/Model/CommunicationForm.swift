//
//  CommunicationForm.swift
//  BoxOffice
//
//  Created by Rhode, Rilla on 2023/03/21.
//

import Foundation

enum CommunicationForm {
    static let dailyBoxOffice = "http://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=d1fb8a58834af4265bbe3cb487e9a994&targetDt="
    
    static let detailMovieInformation = "http://www.kobis.or.kr/kobisopenapi/webservice/rest/movie/searchMovieInfo.json?key=d1fb8a58834af4265bbe3cb487e9a994&movieCd="
}
