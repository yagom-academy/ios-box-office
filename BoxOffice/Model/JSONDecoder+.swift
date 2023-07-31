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
            print("decodedData: \(decodedData)")
            return decodedData
        } catch {
            print ("Decoding Error")
            return nil
        }
    }
}
