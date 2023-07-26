//
//  DecodingManager.swift
//  BoxOffice
//
//  Created by Dasan & Whales on 2023/07/25.
//

import UIKit

struct DecodingManager {
    func decodeJSON<Value: Decodable>(fileName: String) throws -> Value {
        let decoder = JSONDecoder()
        
        guard let dataAsset = NSDataAsset(name: fileName) else {
            throw DataError.notFoundAsset
        }
        
        guard let decodedData: Value = try? decoder.decode(Value.self, from: dataAsset.data) else {
            throw DataError.failedDecoding
        }
        
        return decodedData
    }
}
