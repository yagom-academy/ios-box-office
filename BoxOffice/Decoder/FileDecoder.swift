//
//  FileDecoder.swift
//  BoxOffice
//
//  Created by Christy, Hyemory on 2023/03/20.
//

import UIKit

struct FileDecoder {
    func decodeData<T: Decodable>(_ data: Data, type: T.Type) -> Result<T, NetworkingError> {
        if let result = try? JSONDecoder().decode(type, from: data) {
            return .success(result)
        } else {
            return .failure(.decodeFailed)
        }
    }
}
