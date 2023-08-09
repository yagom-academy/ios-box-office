//
//  JSONDecoder+.swift
//  BoxOffice
//
//  Created by redmango1446 on 2023/07/31.
//

import Foundation

extension JSONDecoder {
    func decodeJSON<T: Decodable>(data: Data) -> T? {
        do {
            let decodedData = try self.decode(T.self, from: data)
            return decodedData
        } catch {
            return nil
        }
    }
}
