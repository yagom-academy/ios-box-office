//
//  Decoder.swift
//  BoxOffice
//
//  Created by Christy, Hyemory on 2023/03/20.
//

import UIKit

struct Decoder {
    private let decoder: JSONDecoder = JSONDecoder()
    
    func decodeAsset<T: Decodable>(assetName: String, type: T.Type) throws -> T? {
        guard let items = NSDataAsset(name: assetName) else {
            throw DecoderError.decodeFailed
        }
        
        do {
            let boxOffice = try decoder.decode(type, from: items.data)
            
            return boxOffice
        } catch DecoderError.decodeFailed {
            print("\(assetName)파일을 디코딩 실패했습니다.")
            
            return nil
        }
    }
}
