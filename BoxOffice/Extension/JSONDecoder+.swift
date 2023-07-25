//
//  JSONDecoder+.swift
//  BoxOffice
//
//  Created by Serana, BMO on 2023/07/25.
//

import UIKit

extension JSONDecoder {
    static func decode<T: Decodable>(fileName: String) -> T? {
        let decoder = JSONDecoder()
        
        guard let asset = NSDataAsset(name: fileName) else { return nil }
        
        guard let data = try? decoder.decode(T.self, from: asset.data) else { return nil }
        
        return data
    }
}
