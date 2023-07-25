//
//  JSONDecoder+.swift
//  BoxOffice
//
//  Created by Serena, BMO on 2023/07/25.
//

import UIKit

extension JSONDecoder {
    static func decode<T: Decodable>(fileName: String) throws -> T {
        let decoder = JSONDecoder()
        
        guard let asset = NSDataAsset(name: fileName) else {
            throw JSONDecoderError.notFoundedAssetFileName
        }
        
        guard let data = try? decoder.decode(T.self, from: asset.data) else {
            throw JSONDecoderError.failureDataDecoding
        }
        
        return data
    }
}
