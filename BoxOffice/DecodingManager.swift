//
//  DecodingManager.swift
//  BoxOffice
//
//  Created by Yetti, Maxhyunm on 2023/07/24.
//

import UIKit

final class DecodingManager {
    static let shared = DecodingManager()
    
    private init() {}
    
    func decode() -> BoxOfficeEntity? {
        guard let path = Bundle.main.path(forResource: "box_office_sample", ofType: "json"),
              let jsonString = try? String(contentsOfFile: path) else {
            return nil
        }
        
        let decoder = JSONDecoder()
        let data = jsonString.data(using: .utf8)
        
        if let data = data,
           let boxoffice = try? decoder.decode(BoxOfficeEntity.self, from: data) {
            return boxoffice
        }
        
        return nil
    }
}
