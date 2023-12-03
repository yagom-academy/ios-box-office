//
//  NetworkManager.swift
//  BoxOffice
//
//  Created by Toy, Morgan on 11/29/23.
//

import Foundation

struct NetworkManager {
    func fetchMovie<T: Decodable>(url: String, type: T.Type, complitionHandler: @escaping (T?) -> Void) {
        executeRequest(with: url, type: type) { safeData in
            guard let data = safeData else { return }
            complitionHandler(data)
        }
    }
    
    private func executeRequest<T: Decodable>(with urlString: String, type: T.Type, complitionHandler: @escaping (T?) -> Void) {
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
            
            
            let safeData = parseJson(type: T.self, data: data)
            complitionHandler(safeData)
        }
        task.resume()
    }
    
    private func parseJson<T: Decodable>(type: T.Type, data: Data) -> T? {
        let decoder = JSONDecoder()
        do {
            let receivedData = try decoder.decode(type, from: data)
            return receivedData
        } catch let error as DecodingError {
            print(error.errorDescription ?? .emptyString)
        } catch {
            print(error.localizedDescription)
        }
        return nil
    }
}
