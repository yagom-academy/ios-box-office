//
//  Array+.swift
//  BoxOffice
//
//  Created by Idinaloq, MARY on 2023/08/08.
//

extension Array {
    subscript(index index: Int) -> Element? {
        return indices ~= index ? self[index] : nil
    }
}
