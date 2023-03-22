//
//  MovieAPI.swift
//  BoxOffice
//
//  Created by goat, songjun on 2023/03/21.
//

import Foundation

struct DailyBoxOfficeAPI {
    let dailyBoxOfficeParser = Parser<DailyBoxOffice>()
    let movieDetailParser = Parser<MovieDetail>()
    
    func loadDailyBoxOffice() {
        guard let url = URL(string: "http://www.kobis.or.kr/kobisopenapi/webservice/rest/movie/searchMovieInfo.json?key=f5eef3421c602c6cb7ea224104795888&movieCd=20124079") else {
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let validData = data else { return }
            print(movieDetailParser.Parse(data: validData)?.movieInformationResult.movieInformation)
            //print(dailyBoxOfficeParser.Parse(data: validData)?.boxOfficeResult.showRange)
            guard let httpURLResponse = response as? HTTPURLResponse, (200...299).contains(httpURLResponse.statusCode) else {
                print("response")
                return
            }
        }.resume()
    }
}

// 일별 박스오피스 : http://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=f5eef3421c602c6cb7ea224104795888&targetDt=20120101
// 영화 상세 : "http://www.kobis.or.kr/kobisopenapi/webservice/rest/movie/searchMovieInfo.json?key=f5eef3421c602c6cb7ea224104795888&movieCd=20124079"

