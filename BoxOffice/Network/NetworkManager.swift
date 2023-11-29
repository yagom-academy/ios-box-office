//
//  NetworkManager.swift
//  BoxOffice
//
//  Created by Toy, Morgan on 11/29/23.
//

import Foundation

struct NetworkManager {
    private let kobisURL = "https://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?"
    private let key = "d9538442725f83fb63d49ae6e965066a"
    
    func fetchMovie(complitionHandler: @escaping (BoxOffice?) -> Void) {
         let urlString = "\(kobisURL)key=\(key)&targetDt=\(fetchTodayDate())"
         executeRequest(with: urlString) {
             complitionHandler($0)
         }
     }
    
    private func fetchTodayDate() -> String {
        let currentDate = Date()
        guard let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: currentDate) else { return "" }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd"
        let targetDate = dateFormatter.string(from: yesterday)

        return targetDate
    }
    
    private func parseJson(_ receiveData: Data) -> BoxOffice? {
        let decoder = JSONDecoder()
        do {
            let receivedData = try decoder.decode(BoxOffice.self, from: receiveData)
            return receivedData
        } catch let error as NetworkManagerError {
            print(error.localizedDescription)
        } catch {
            print(error.localizedDescription)
        }
        return nil
    }
    
    private func executeRequest(with urlString: String, complitionHandler: @escaping (BoxOffice?) -> Void) {
        
        guard let url = URL(string: urlString) else { return }
        
        let urlSession = URLSession(configuration: .default)
        
        let task = urlSession.dataTask(with: url) { (data, response, error) in
            guard error == nil else {
                return
            }
            
            // response 다루기
            
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
}


