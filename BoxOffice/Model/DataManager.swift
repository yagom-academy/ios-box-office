//
//  DataManager.swift
//  BoxOffice
//
//  Created by kyungmin, Erick on 2023/07/28.
//

import Foundation

struct DataManager {
    func decodeJSON<T: Decodable>(data: Data) -> T? {
        do {
            let decodedData = try JSONDecoder().decode(T.self, from: data)
            
            return decodedData
        } catch {
            return nil
        }
    }
}
