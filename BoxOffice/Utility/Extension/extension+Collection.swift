//
//  extension+Collection.swift
//  BoxOffice
//
//  Created by Muri, Rowan on 2023/04/05.
//

extension Collection {
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
