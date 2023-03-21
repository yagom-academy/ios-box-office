//
//  BoxOfficeParser.swift
//  BoxOffice
//
//  Created by goat, songjun on 2023/03/20.
//

import UIKit

struct Parser<T: Decodable> {
    func Parse(jsonFileName: String) -> T? {
        var decodingResult: T?
        let jsonDecoder = JSONDecoder()
        
        guard let jsonData: NSDataAsset = NSDataAsset(name: jsonFileName) else {
            print("에러 : jsonData 없음")
            return nil
        }
        
        do {
            decodingResult = try jsonDecoder.decode(T.self, from: jsonData.data)
            return decodingResult
        } catch {
            print("에러 : decode 안됨")
            return nil
        }
    }
}

