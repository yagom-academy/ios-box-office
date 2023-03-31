//
//  JSONConverter.swift
//  BoxOffice
//
//  Created by Seoyeon Hong on 2023/03/22.
//

import Foundation

final class JSONConverter {
    
    static let shared = JSONConverter()

    func decodeData<T: Decodable>(_ data: Data, T: T.Type) throws -> T {
        let decoder = JSONDecoder()
        
        do {
            let decodedData = try decoder.decode(T.self, from: data)
            return decodedData
        } catch {
            throw error
        }
    }
    
}
