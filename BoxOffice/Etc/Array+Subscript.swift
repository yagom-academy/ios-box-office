//
//  Array+Subscript.swift
//  BoxOffice
//
//  Created by kaki, harry on 2023/03/27.
//

extension Array {
    subscript (safe index: Int) -> Element? {
        return indices ~= index ? self[index] : nil
    }
}
