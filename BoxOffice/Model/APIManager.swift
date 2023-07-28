//
//  APIManager.swift
//  BoxOffice
//
//  Created by redmango, Jusbug on 2023/07/26.
//

import Foundation

struct APIManager {
    let session = URLSession.shared
    
    func fetchData(service: Service) {
        guard let correctUrl = URL(string: service.rawValue) else {
            print("Wrong URL")
            return
        }
        
        let request = URLRequest(url: correctUrl)
        
        session.dataTask(with: request) { data, response, error in
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
            
            if safeData == data {
                do {
                    let decoder = JSONDecoder()
                    let decodedData = try decoder.decode(BoxOffice.self, from: safeData)
                } catch {
                    print ("Decoding Error")
                }
            }
        }.resume()
    }
}
