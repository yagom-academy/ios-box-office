//
//  Array+.swift
//  BoxOffice
//
//  Created by EtialMoon, Minsup on 2023/08/11.
//

extension Array {
    subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
