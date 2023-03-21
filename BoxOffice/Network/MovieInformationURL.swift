//
//  MovieInformationURL.swift
//  BoxOffice
//
//  Created by 리지, kokkilE on 2023/03/21.
//

struct MovieInfomationURL: Requestable {
    var url: String
    var baseURL: String = "http://www.kobis.or.kr/kobisopenapi/webservice/rest/movie/searchMovieInfo.json"
    var key: String = "f5eef3421c602c6cb7ea224104795888"
    var movieCode: String
}


