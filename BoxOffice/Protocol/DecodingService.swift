//
//  DecodingService.swift
//  BoxOffice
//
//  Created by karen on 2023/08/12.
//

import Foundation

protocol DecodingService {
    func decode<Element: Decodable>(_ type: Element.Type, from data: Data) -> Element?
}
