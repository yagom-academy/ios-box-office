//
//  MovieDetailsAttributeTransformer.swift
//  BoxOffice
//
//  Created by 리지, kokkilE on 2023/04/11.
//

import Foundation

final class MovieDetailsAttributeTransformer: NSSecureUnarchiveFromDataTransformer {
    override class var allowedTopLevelClasses: [AnyClass] {
        [MovieDetails.self]
    }
    
    static func register() {
        let className = String(describing: MovieDetailsAttributeTransformer.self)
        let name = NSValueTransformerName(className)
        let transformer = MovieDetailsAttributeTransformer()
        
        ValueTransformer.setValueTransformer(transformer, forName: name)
    }
}
