//
//  NetworkManager.swift
//  BoxOffice
//
//  Created by Toy, Morgan on 11/29/23.
//

import Foundation

struct NetworkManager {
    private let kobisURL = "https://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?"
    private let detailURL = "https://www.kobis.or.kr/kobisopenapi/webservice/rest/movie/searchMovieInfo.json?"
    private let key = "d9538442725f83fb63d49ae6e965066a"
    
    func fetchMovie(complitionHandler: @escaping (BoxOffice?) -> Void) {
        let urlString = "\(kobisURL)key=\(key)&targetDt=\(fetchTodayDate())"
        
        executeRequest(with: urlString) {
            complitionHandler($0)
        }
    }
    
    func fetchMovieDetail(movieCd: String) {
        let urlString = "\(kobisURL)key=\(key)&movieCd=\(movieCd)"
        
        executeRequest(with: urlString) {
            complitionHandler($0)
        }
    }
    
    private func fetchTodayDate() -> String {
        let currentDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = DateFormat.yyyyMMdd
        
        guard let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: currentDate) else { return .empty }
        
        let targetDate = dateFormatter.string(from: yesterday)
        
        return targetDate
    }
    
    private func executeRequest(with urlString: String, complitionHandler: @escaping (BoxOffice?) -> Void) {
        
        guard let url = URL(string: urlString) else { return }
        
        let urlSession = URLSession(configuration: .default)
        
        let task = urlSession.dataTask(with: url) { (data, response, error) in
            guard error == nil else {
                return
            }

            guard let data = data else {
                complitionHandler(nil)
                return
            }
            
            if let movieData = parseJson(data) {
                complitionHandler(movieData)
            } else {
                complitionHandler(nil)
                return
            }
        }
        task.resume()
    }
    
    private func parseJson(_ receiveData: Data) -> BoxOffice? {
        let decoder = JSONDecoder()
        do {
            let receivedData = try decoder.decode(BoxOffice.self, from: receiveData)
            return receivedData
        } catch let error as NetworkManagerError {
            print(error.errorDescription ?? .empty)
        } catch {
            print(error.localizedDescription)
        }
        return nil
    }
}
