//
//  DataManaging.swift
//  BoxOffice
//
//  Created by karen on 2023/07/26.
//

import Foundation

protocol DataManaging {
    func decodeJSON<Element: Decodable>(_ type: Element.Type) -> Element?
    func loadData(named name: String) -> Data?
    func decodeData<Element: Decodable>(_ type: Element.Type, from data: Data) -> Element?
}
