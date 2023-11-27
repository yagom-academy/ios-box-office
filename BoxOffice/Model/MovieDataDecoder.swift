//
//  movieDataDecoder.swift
//  BoxOffice
//
//  Created by Toy, Morgan on 11/27/23.
//

import UIKit

struct MovieDataDecoder {
    static func decodeAssetData<T: Decodable>(assetName: String, decoder: JSONDecoder) throws -> T {
        guard let asset = NSDataAsset(name: assetName) else {
            throw ErrorMessage.emptyAssetData
        }
        
        return try decoder.decode(T.self, from: asset.data)
    }
}
