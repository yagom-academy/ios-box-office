//
//  MovieAttributeTransformer.swift
//  BoxOffice
//
//  Created by 리지, kokkilE on 2023/04/10.
//

import Foundation

final class MovieAttributeTransformer: NSSecureUnarchiveFromDataTransformer {
    override class var allowedTopLevelClasses: [AnyClass] {
        [Movies.self]
    }
    
    static func register() {
        let className = String(describing: MovieAttributeTransformer.self)
        let name = NSValueTransformerName(className)
        let transformer = MovieAttributeTransformer()
        
        ValueTransformer.setValueTransformer(transformer, forName: name)
    }
}
