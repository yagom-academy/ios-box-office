//
//  JSONDecodingManager.swift
//  BoxOffice
//
//  Created by EtialMoon, Minsup on 2023/08/08.
//

import Foundation

final class JSONDecodingManager {
    static private let decoder = JSONDecoder()
    
    static func decode<T: Decodable>(from data: Data) throws -> T {
        guard let decoded = try? decoder.decode(T.self, from: data) else {
            throw DecodingError.decodingFailed
        }
        return decoded
    }
}
