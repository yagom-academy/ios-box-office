//
//  BoxOfficeParser.swift
//  BoxOffice
//
//  Created by goat, songjun on 2023/03/20.
//

import Foundation

struct Parser<T: Decodable> {
    func parse(data: Data) -> T? {
        var decodingResult: T?
        let jsonDecoder = JSONDecoder()
        
        do {
            decodingResult = try jsonDecoder.decode(T.self, from: data)
            return decodingResult
        } catch {
            print("에러 : decode 안됨")
            return nil
        }
    }
}
