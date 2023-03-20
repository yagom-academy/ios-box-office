//
//  DataManager.swift
//  BoxOffice
//
//  Created by Muri, Rowan on 2023/03/20.
//

import UIKit

enum DataManager {
    static func parse(from data: Data) -> BoxOfficeResult? {
        let decoder = JSONDecoder()
        
        do {
            let result = try decoder.decode(BoxOfficeResult.self, from: data)
            return result
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
}
