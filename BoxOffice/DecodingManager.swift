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
    
    func decode(_ data: Data?) -> BoxOfficeEntity? {
        let decoder = JSONDecoder()
        
        if let data = data,
           let boxoffice = try? decoder.decode(BoxOfficeEntity.self, from: data) {
            return boxoffice
        }
        
        return nil
    }
}
