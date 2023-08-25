//
//  NetworkManager.swift
//  BoxOffice
//
//  Created by karen on 2023/08/06.
//

import UIKit

final class NetworkManager: NetworkService {
    static let shared = NetworkManager(session: URLSession.shared)
    private let session: URLSession
    
    init(session: URLSession) {
        self.session = session
    }
    
    func fetchData(request: URLRequest, completion: @escaping (Result<Data, BoxOfficeError>) -> Void) {
        let task = session.dataTask(with: request) { data, response, error in
            self.handleResponse(data: data, response: response, error: error, completion: completion)
        }
        
        task.resume()
    }
    
    func fetchImage(from url: URL, completion: @escaping (Result<(UIImage, CGSize), BoxOfficeError>) -> Void) {
        let task = session.dataTask(with: url) { data, response, error in
            guard error == nil else {
                completion(.failure(.failureRequest))
                return
            }
            
            guard let data = data,
                  let image = UIImage(data: data) else {
                completion (.failure(.failureDecoding))
                return
            }
            
            completion(.success((image, CGSize(width: image.size.width, height: image.size.height))))
        }
        
        task.resume()
    }
}
