//
//  DataManager.swift
//  BoxOffice
//
//  Created by Muri, Rowan on 2023/03/20.
//

import UIKit

struct DataManager {
    func parse<T: Decodable>(from data: Data, returnType: T.Type) throws -> T? {
        let decoder = JSONDecoder()
        
        do {
            let result = try decoder.decode(returnType, from: data)
            return result
        } catch {
            throw DecodeError.decodeFail
        }
    }
}
