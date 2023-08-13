//
//  DefaultDecodingService.swift
//  BoxOffice
//
//  Created by karen on 2023/08/12.
//

import Foundation

struct DefaultDecodingService: DecodingService {
    func decode<Element: Decodable>(_ type: Element.Type, from data: Data) -> Element? {
        let decoder = JSONDecoder()
        return try? decoder.decode(type, from: data)
    }
}
