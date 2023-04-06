//
//  Array+extension.swift
//  BoxOffice
//
//  Created by Christy, Hyemory on 2023/04/02.
//

extension Array {
    subscript (safe index: Int) -> Element? {
        return indices ~= index ? self[index] : nil
    }
}
