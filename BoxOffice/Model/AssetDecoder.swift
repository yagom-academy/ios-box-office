//
//  AssetDecoder.swift
//  BoxOffice
//
//  Created by Christy, Hyemory on 2023/03/20.
//

import UIKit

struct AssetDecoder {
    private let decoder: JSONDecoder = JSONDecoder()
    
    func decode<T: Decodable>(name: String, type: T.Type) throws -> T? {
        guard let items = NSDataAsset(name: name) else {
            throw DecoderError.decodeFailed
        }
        
        do {
            let result = try decoder.decode(type, from: items.data)
            
            return result
        } catch DecoderError.decodeFailed {
            print("\(name)파일 디코딩에 실패했습니다.")
            
            return nil
        }
    }
}
