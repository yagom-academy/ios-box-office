//
//  MovieAPI.swift
//  BoxOffice
//
//  Created by goat, songjun on 2023/03/21.
//

import Foundation

protocol BoxOfficeAPIDelegate {
    func fetchAPIData<T: Decodable>(data: T)
}

struct BoxOfficeAPI {
  
    var delegate: BoxOfficeAPIDelegate?
    
    func loadBoxOfficeAPI<T: Decodable>(urlAddress: String, parserType: Parser<T>) {
        guard let url = URL(string: urlAddress) else {
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let validData = data else { return }
            guard let parsedData = parserType.Parse(data: validData) else {return}
            delegate?.fetchAPIData(data: parsedData)
            guard let httpURLResponse = response as? HTTPURLResponse, (200...299).contains(httpURLResponse.statusCode) else {
                print("response")
                return
            }
        }.resume()
    }
}

// 일별 박스오피스 : http://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=f5eef3421c602c6cb7ea224104795888&targetDt=20120101
// 영화 상세 : "http://www.kobis.or.kr/kobisopenapi/webservice/rest/movie/searchMovieInfo.json?key=f5eef3421c602c6cb7ea224104795888&movieCd=20124079"

