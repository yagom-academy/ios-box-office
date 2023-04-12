//
//  DataManager.swift
//  BoxOffice
//
//  Created by 리지, kokkilE on 2023/04/11.
//

import Foundation
import CoreData

protocol DataManager {
    
    func create(key: String, value: [Any])
    
    func read(key: String) -> Any?
    
    func update(key: String, value: [Any])
    
    func delete()
}
