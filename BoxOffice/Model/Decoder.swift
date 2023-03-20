//
//  Decoder.swift
//  BoxOffice
//
//  Created by Christy, Hyemory on 2023/03/20.
//

import UIKit

class Decoder {
    let decoder: JSONDecoder = JSONDecoder()
    
    func decodeBoxOffice() -> BoxOffice? {
        var boxOffice: BoxOffice?
        
        guard let items: NSDataAsset = NSDataAsset(name: "box_office_sample") else { return nil }
        
        do {
            boxOffice = try decoder.decode(BoxOffice.self, from: items.data)
        } catch {
            print(error.localizedDescription)
        }
        
        return boxOffice
    }
}
