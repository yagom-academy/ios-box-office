//
//  DataDecoder.swift
//  BoxOffice
//
//  Created by Toy, Morgan on 11/27/23.
//

import UIKit

struct DataDecoder {
    static func parseAssetJson<T: Decodable>(assetName: String, decoder: JSONDecoder) throws -> T {
        guard let asset = NSDataAsset(name: assetName) else {
            throw DecodingError.emptyAssetData
        }
        
        return try decoder.decode(T.self, from: asset.data)
    }
    
    static func parseJson<T: Decodable>(type: T.Type, data: Data) -> T? {
        let decoder = JSONDecoder()
        do {
            let receivedData = try decoder.decode(type, from: data)
            return receivedData
        } catch let error as DecodingError {
            print(error.errorDescription ?? "")
        } catch {
            print(error.localizedDescription)
        }
        return nil
    }
}
