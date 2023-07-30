//
//  DataManager.swift
//  BoxOffice
//
//  Created by karen on 2023/07/28.
//

import UIKit

struct DataManager: DataManaging {
    private let decoder: JSONDecoder = JSONDecoder()

    func decodeJSON<Element: Decodable>(_ type: Element.Type) -> Element? {
        guard let itemsData = loadData(named: DataNamespace.item),
              let decodedItems = decodeData(Element.self, from: itemsData)
        else { return nil }

        return decodedItems
    }

    func loadData(named name: String) -> Data? {
        return NSDataAsset(name: name)?.data
    }

    func decodeData<Element: Decodable>(_ type: Element.Type, from data: Data) -> Element? {
        return try? decoder.decode(type, from: data)
    }
}
