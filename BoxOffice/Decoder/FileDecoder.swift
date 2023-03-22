//
//  FileDecoder.swift
//  BoxOffice
//
//  Created by Christy, Hyemory on 2023/03/20.
//

import UIKit

struct FileDecoder {
    var data: Data?
    
    mutating func fetchAsset(name: String) {
        data = NSDataAsset(name: name)?.data
    }
    
    func decodeData<T: Decodable>(type: T.Type) throws -> T? {
        guard let data = data else {
            throw DecoderError.decodeFailed
        }
        
        do {
            let result = try JSONDecoder().decode(type, from: data)
            
            return result
        } catch DecoderError.decodeFailed {
            print("\(data.description) 디코딩에 실패했습니다.")
            
            return nil
        }
    }
}
