//
//  DetailsAttributeTransformer.swift
//  BoxOffice
//
//  Created by 리지, kokkilE on 2023/04/11.
//

import Foundation

final class DetailsAttributeTransformer: NSSecureUnarchiveFromDataTransformer {
    override class var allowedTopLevelClasses: [AnyClass] {
        [Details.self]
    }
    
    static func register() {
        let className = String(describing: DetailsAttributeTransformer.self)
        let name = NSValueTransformerName(className)
        let transformer = DetailsAttributeTransformer()
        
        ValueTransformer.setValueTransformer(transformer, forName: name)
    }
}
