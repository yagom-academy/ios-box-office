//
//  Decoder.swift
//  BoxOffice
//
//  Created by 리지, kokkilE on 2023/03/21.
//

import UIKit

enum Decoder {
    static func parseJSON<element: Decodable>(_ fileName: String, returnType: element.Type) -> element? {
        guard let dataAsset = NSDataAsset(name: fileName) else { return nil }
        
        do {
            let jsonDecoder = JSONDecoder()
            let result = try jsonDecoder.decode(returnType, from: dataAsset.data)
            return result
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
}
