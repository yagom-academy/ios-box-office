//
//  DataManager.swift
//  BoxOffice
//
//  Created by Muri, Rowan on 2023/03/20.
//

import UIKit

class DataManager {
    var delegate: DataManagerDelegate?
    var kobisUrlSession = URLSession(configuration: .default)
    
    enum Services {
        case dailyBoxOffice
        case movieDetails
        
        var urlString: String {
            switch self {
            case .dailyBoxOffice:
                return "http://www.kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json"
            case .movieDetails:
                return "http://www.kobis.or.kr/kobisopenapi/webservice/rest/movie/searchMovieInfo.json"
            }
        }
    }
    
    func parse<T: Decodable>(from data: Data, returnType: T.Type) throws -> T? {
        let decoder = JSONDecoder()
        
        do {
            let result = try decoder.decode(returnType, from: data)
            return result
        } catch {
            throw DecodeError.decodeFail
        }
    }
    
    func startLoad<T: Decodable>(for service: Services, type: T.Type) {
        guard let url = URL(string: service.urlString) else { return }
        
        let task = kobisUrlSession.dataTask(with: url) { data, response, error in
            if let error = error {
                print(error)
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                print("서버와 통신에 실패했습니다.")
                return
            }
            
            if let mimeType = httpResponse.mimeType, mimeType == "application/json",
               let data = data {
                DispatchQueue.main.async { [weak self] in
                    do {
                        switch service {
                        case .dailyBoxOffice:
                            self?.delegate?.dailyBoxOfficeData = try self?.parse(from: data, returnType: T.self) as? DailyBoxOffice
                        case .movieDetails:
                            self?.delegate?.movieDetailsData = try self?.parse(from: data, returnType: T.self) as? MovieDetails
                        }
                    } catch {
                        print(error.localizedDescription)
                    }
                }
            }
        }
        task.resume()
    }
}
