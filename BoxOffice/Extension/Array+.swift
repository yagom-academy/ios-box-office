//
//  Array+.swift
//  BoxOffice
//
//  Created by Rhode, Rilla on 2023/04/06.
//

extension Array {
    subscript(index index: Int) -> Element? {
        return indices ~= index ? self[index]  : nil
    }
}
