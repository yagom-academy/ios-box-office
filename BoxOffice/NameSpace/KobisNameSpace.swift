//
//  KobisNameSpace.swift
//  BoxOffice
//
//  Created by Serena, BMO on 2023/07/28.
//

enum KobisNameSpace {
    static let key: String = "key"
    static let keyValue: String = "f5eef3421c602c6cb7ea224104795888"
    static let targetDt: String = "targetDt"
    static let movieCd: String = "movieCd"
    static let baseUrl: String = "http://www.kobis.or.kr/kobisopenapi/webservice/rest"
    static let detailMovieInfoUrl: String = baseUrl + "/movie/searchMovieInfo.json"
    static let dailyBoxOfficeUrl: String = baseUrl + "/boxoffice/searchDailyBoxOfficeList.json"
}
