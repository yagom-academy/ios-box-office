//
//  AssetDecoder.swift
//  BoxOffice
//
//  Created by Christy, Hyemory on 2023/03/20.
//

import UIKit

extension JSONDecoder {
    func decodeData<T: Decodable>(_ data: Data?, type: T.Type) throws -> T? {
        guard let data = data else {
            throw DecoderError.decodeFailed
        }
        
        do {
            let result = try self.decode(type, from: data)
            
            return result
        } catch DecoderError.decodeFailed {
            print("\(data.description) 디코딩에 실패했습니다.")
            
            return nil
        }
    }
}
