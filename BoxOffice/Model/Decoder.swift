//
//  Decoder.swift
//  BoxOffice
//
//  Created by Christy, Hyemory on 2023/03/20.
//

import UIKit

struct Decoder {
    private let decoder: JSONDecoder = JSONDecoder()
    
    func decodeBoxOffice() -> BoxOffice? {
        guard let items: NSDataAsset = NSDataAsset(name: "box_office_sample") else { return nil }
        
        do {
            let boxOffice = try decoder.decode(BoxOffice.self, from: items.data)
            
            return boxOffice
        } catch {
            print(error.localizedDescription)
            
            return nil
        }
    }
}
