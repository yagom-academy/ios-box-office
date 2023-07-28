//
//  APIManager.swift
//  BoxOffice
//
//  Created by redmango, Jusbug on 2023/07/26.
//

import Foundation

struct APIManager {
    let session = URLSession.shared
    
    func fetchData(service: Service, completion: @escaping (Data?) -> Void) {
        guard let url = URL(string: service.rawValue) else {
            print("Wrong URL")
            return
        }
        
        let dataTask = session.dataTask(with: url) { data, response, error in
            guard error == nil else {
                print("error: \(String(describing: error))")
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                print("Response Error")
                return
            }
            
            guard (200..<300).contains(httpResponse.statusCode) else {
                print("Server Error: \(httpResponse.statusCode)")
                return
            }
            
            guard let safeData = data else {
                print("None of Data")
                return
            }
            
            completion(safeData)
            
        }
        
        dataTask.resume()
    }
    
    func decodeJSON<T: Decodable>(service: Service, data: Data) -> T? {
        do {
            let decoder = JSONDecoder()
            let decodedData = try decoder.decode(T.self, from: data)
            print("decodedData: \(decodedData)")
            return decodedData
        } catch {
            print ("Decoding Error")
            return nil
        }
    }
}
