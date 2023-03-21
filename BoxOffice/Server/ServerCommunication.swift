//
//  ServerCommunication.swift
//  BoxOffice
//
//  Created by 김성준 on 2023/03/21.
//

import Foundation

struct ServerCommunication {
    
    func startLoad(urlText: String) {
        guard let url = URL(string: urlText) else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { data, response, error in

            guard let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200 else {
                print("response")
                return
            }
            let mimeType = response?.mimeType
            
            if ((mimeType?.lowercased().contains("text")) != nil) {
                
                DispatchQueue.main.async {


                }
            }
        }.resume()
    }
    
}
