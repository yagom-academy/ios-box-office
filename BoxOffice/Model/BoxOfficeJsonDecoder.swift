//
//  BoxOfficeJsonDecoder.swift
//  BoxOffice
//
//  Created by vetto, brody on 23/03/20.
//

import UIKit

final class BoxOfficeJsonDecoder: JSONDecoder {
    func loadJsonData<T: Decodable>(name: String, type: T.Type) throws -> T {
        guard let dataAsset = NSDataAsset(name: name) else {
            throw DataAssetError.invalidFileName
        }
        
        return try self.decode(type, from: dataAsset.data)
    }
}
