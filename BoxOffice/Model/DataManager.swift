//
//  DataManager.swift
//  BoxOffice
//
//  Created by Muri, Rowan on 2023/03/20.
//

import UIKit

enum DataManager {
    static func parse() -> BoxOfficeResult? {
        let decoder = JSONDecoder()
        
        guard let dataAsset = NSDataAsset(name: "DailyOffice") else { return nil }
        
        do {
            let result = try decoder.decode(BoxOfficeResult.self, from: dataAsset.data)
            return result
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
}
