//
//  Decoder.swift
//  BoxOffice
//
//  Created by jyubong on 12/4/23.
//

import Foundation

struct Decoder {
    func parse<T: Decodable>(data: Data, type: T.Type) throws -> T {
        return try JSONDecoder().decode(type, from: data)
    }
}
