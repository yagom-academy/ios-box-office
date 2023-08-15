//
//  URLList.swift
//  BoxOffice
//
//  Created by 훈민트 on 2023/08/15.
//

enum URLList {
    case boxOfficeData
    case movieInformation
    
    var url: String {
        switch self {
        case .boxOfficeData:
            return "http://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=f5eef3421c602c6cb7ea224104795888&targetDt=20120101"
        case .movieInformation:
            return "http://www.kobis.or.kr/kobisopenapi/webservice/rest/movie/searchMovieInfo.json?key=f5eef3421c602c6cb7ea224104795888&movieCd=20124079"
        }
    }
}
