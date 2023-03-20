//
//  Decoder.swift
//  BoxOffice
//
//  Created by Rhode, Rilla on 2023/03/20.
//

import UIKit

final class Decoder {
    
    private let decoder = JSONDecoder()
    private let fileName = "box_office_sample"

    func decodeBoxOfficeResult() -> BoxOffice? {
        
        guard let boxOffice: NSDataAsset  = NSDataAsset(name: fileName) else {
            return nil
        }
        
        do{
            let decodedBoxOffice: BoxOffice = try decoder.decode(BoxOffice.self, from: boxOffice.data)
            return decodedBoxOffice
        } catch {
            print("이곳만은 안된다...!")
            return nil
        }
        
    }
}
