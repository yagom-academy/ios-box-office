//
//  DataManager.swift
//  BoxOffice
//
//  Created by kyungmin, Erick on 2023/07/28.
//

import Foundation

enum DataManager {
    static func decodeJSON<T: Decodable>(data: Data) throws -> T {
        do {
            let decodedData = try JSONDecoder().decode(T.self, from: data)
            
            return decodedData
        } catch {
            throw DataError.decodeJSONFailed
        }
    }
}
