//
//  Decoder.swift
//  BoxOffice
//
//  Created by Rhode, Rilla on 2023/03/20.
//

import UIKit

final class DecodeManager<T: Decodable> {
    
    private let decoder = JSONDecoder()
   

    func decodeBoxOffice(fileName: String) -> T? {
        
        guard let boxOffice: NSDataAsset  = NSDataAsset(name: fileName) else {
            return nil
        }
        
        do{
            let decodedBoxOffice: T = try decoder.decode(T.self, from: boxOffice.data)
            return decodedBoxOffice
        } catch {
            return nil
        }
        
    }
}
