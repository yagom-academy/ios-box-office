//
//  NetworkManager.swift
//  BoxOffice
//
//  Created by 리지, kokkilE on 2023/03/21.
//

import Foundation

class NetworkManager: NetworkRequestable {
    
    func makeUrlRequest(method: RequestMethod, request: Requestable) -> URLRequest? {
        guard let url = URL(string: request.url) else { return nil }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.description
        
        return urlRequest
    }
    
    func request<element: Decodable>(method: RequestMethod, url: Requestable, body: Data?, returnType: element.Type, completion: @escaping (Any) -> Void) {
        
        guard let urlRequest = makeUrlRequest(method: method, request: url) else {
            print("URLRequest 생성 실패")
            return
        }
        
        let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                print(response as Any)
                return
            }
            
            if let mimeType = httpResponse.mimeType, mimeType == "application/json",
               let data = data {
                guard let result = Decoder.parseJSON(data, returnType: returnType) else {
                    return
                }
                completion(result)
            }
        }
        task.resume()
    }
}
