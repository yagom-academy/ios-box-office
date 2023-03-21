//
//  Decoder.swift
//  BoxOffice
//
//  Created by Rhode, Rilla on 2023/03/20.
//

import UIKit

final class Decoder {
    
    private let decoder = JSONDecoder()

    func decodeBoxOffice(data: Data) -> BoxOffice? {
        do{
            let decodedBoxOffice: BoxOffice = try decoder.decode(BoxOffice.self, from: data)
            return decodedBoxOffice
        } catch {
            return nil
        }
    }
}
