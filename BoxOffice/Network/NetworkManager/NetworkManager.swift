//
//  NetworkManager.swift
//  BoxOffice
//
//  Created by 리지, kokkilE on 2023/03/21.
//

import Foundation

class NetworkManager: NetworkRequestable {
    
    func makeUrlRequest(method: RequestMethod, request: Requestable) -> URLRequest? {
        guard let url = request.url else { return nil }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.description
        
        return urlRequest
    }
    
    func request<element: Decodable>(method: RequestMethod, url: Requestable, body: Data?, returnType: element.Type, completion: @escaping (Any) -> Void) {
        
        guard let urlRequest = makeUrlRequest(method: method, request: url) else {
            completion(NetworkError.invalidURL)
            return
        }
        
        let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            if error != nil {
                completion(NetworkError.unknown)
                return
            }
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                completion(NetworkError.reponseStatusCode)
                return
            }
            
            if let mimeType = httpResponse.mimeType, mimeType == "application/json",
               let data = data {
                guard let result = Decoder.parseJSON(data, returnType: returnType) else {
                    completion(NetworkError.decode)
                    return
                }
                completion(result)
            }
        }
        task.resume()
    }
}
