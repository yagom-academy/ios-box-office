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
    var urlMaker = URLMaker()
    
    func startLoadDailyBoxOfficeData(date: String) {
        guard let url = urlMaker.makeDailyBoxOfficeURL(date: date) else { return }
        
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
                        self?.delegate?.dailyBoxOfficeData = try self?.parse(from: data, returnType: DailyBoxOffice.self)
                    } catch {
                        print(error.localizedDescription)
                    }
                }
            }
        }
        task.resume()
    }
    
    private func parse<T: Decodable>(from data: Data, returnType: T.Type) throws -> T? {
        let decoder = JSONDecoder()
        
        do {
            let result = try decoder.decode(returnType, from: data)
            return result
        } catch {
            throw DecodeError.decodeFail
        }
    }
}



//case .movieDetails:
//    self?.delegate?.movieDetailsData = try self?.parse(from: data, returnType: T.self) as? MovieDetails
