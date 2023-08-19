//
//  Decodable+.swift
//  BoxOffice
//
//  Created by 훈민트 on 2023/08/16.
//

import Foundation

extension Decodable {
    func decode(data: Data) -> Self? {
        var result: Self?
        
        do {
            result = try JSONDecoder().decode(Self.self, from: data)
        } catch {
            print(error.localizedDescription)
        }

        return result
    }
}


