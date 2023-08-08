//
//  JSONDecoder+.swift
//  BoxOffice
//
//  Created by EtialMoon, Minsup on 2023/08/08.
//

import Foundation

extension JSONDecoder {
    static private let decoder = JSONDecoder()
    static func decode<T: Decodable>(from data: Data) throws -> T {
        guard let decoded = try? decoder.decode(T.self, from: data) else {
            throw DecodingError.decodingFailed
        }
        return decoded
    }
}
