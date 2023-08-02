//
//  JSONDecoder +.swift
//  BoxOffice
//
//  Created by Hyungmin Lee on 2023/08/01.
//

import Foundation

extension JSONDecoder {
     func decodeResponseData<T: Decodable>(_ responseData: Data, _ completionHandler: (Result<T, APIError>) -> Void) {
        do {
            let jsonDecoder = JSONDecoder()
            let decodingData = try jsonDecoder.decode(T.self, from: responseData)
            
            completionHandler(.success(decodingData))
        } catch {
            completionHandler(.failure(.decodingFail))
        }
    }
}
