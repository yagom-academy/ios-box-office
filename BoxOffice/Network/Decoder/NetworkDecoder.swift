//
//  NetworkDecoder.swift
//  BoxOffice
//
//  Created by Christy, Hyemory on 2023/03/20.
//

import Foundation

struct NetworkDecoder {
//    func decode<T: Decodable>(data: Data, type: T.Type) -> Result<T, Error> {
//        if let result = try? JSONDecoder().decode(type, from: data) {
//            return .success(result)
//        } else {
//            return .failure(NetworkingError.decodeFailed)
//        }
//    }
    
    func decode<T: Decodable>(data: Data, type: T.Type) -> T? {
        do {
            let result = try JSONDecoder().decode(type, from: data)
            
            return result
        } catch {
            print(error.localizedDescription)
            
            return nil
        }
    }
}
