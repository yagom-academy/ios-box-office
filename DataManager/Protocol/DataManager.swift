//
//  DataManager.swift
//  BoxOffice
//
//  Created by 리지, kokkilE on 2023/04/11.
//

import Foundation
import CoreData

protocol DataManager {
    
    associatedtype Element
    associatedtype Entity
    
    func create(key: String, value: [Element])
    
    func read(key: String) -> Entity?
    
    func update(key: String, value: [Element])
    
    func delete()
}
