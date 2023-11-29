//
//  DataDecoder.swift
//  BoxOffice
//
//  Created by Toy, Morgan on 11/27/23.
//

import UIKit

struct DataDecoder {
    static func decodeAssetData<T: Decodable>(assetName: String, decoder: JSONDecoder) throws -> T {
        guard let asset = NSDataAsset(name: assetName) else {
            throw DecodingError.emptyAssetData
        }
        
        return try decoder.decode(T.self, from: asset.data)
    }
}
