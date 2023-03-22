//
//  DailyBoxOfficeURL.swift
//  BoxOffice
//
//  Created by 리지, kokkilE on 2023/03/21.
//

struct DailyBoxOfficeURL {
    var url: String
    var baseURL: String = "http://www.kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json"
    var key: String = "f5eef3421c602c6cb7ea224104795888"
    var targetDate: String
    var itemPerPage: String?
    var movieType: MovieType?
    var nationalCode: NationalCode?
    var wideAreaCode: String?
    
    init(targetDate: String , itemPerPage: String? = nil, movieType: MovieType? = nil, nationalCode: NationalCode? = nil, wideAreaCode: String? = nil) {
        self.targetDate = targetDate
        self.itemPerPage = itemPerPage
        self.movieType = movieType
        self.nationalCode = nationalCode
        self.wideAreaCode = wideAreaCode
        self.url = baseURL + "?key=" + key + "&targetDt=" + targetDate
        if let itemPerPage = self.itemPerPage {
            self.url = self.url + "&itemPerPage=" + itemPerPage
        }
        if let movieType = self.movieType?.rawValue {
            self.url = self.url + "&multiMovieYn=" + movieType
        }
        if let nationalCode = self.nationalCode?.rawValue {
            self.url = self.url + "&repNationCd=" + nationalCode
        }
        if let wideAreaCode = self.wideAreaCode {
            self.url = self.url + "&wideAreaCd=" + wideAreaCode
        }
    }
}
