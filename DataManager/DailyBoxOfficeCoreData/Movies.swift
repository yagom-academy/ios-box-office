//
//  Movies.swift
//  BoxOffice
//
//  Created by 리지, kokkilE on 2023/04/10.
//
//

import Foundation

final class Movies: NSObject {
    var movieList: [Movie] = []
    
    init(movieList: [Movie]) {
        self.movieList = movieList
    }
    
    convenience required init?(coder: NSCoder) {
        let movieList = coder.decodeObject(of: [NSArray.self, Movie.self, NSString.self], forKey: "movieList")
        
        self.init(movieList: movieList as! [Movie])
    }
}

extension Movies: NSSecureCoding {
    static var supportsSecureCoding: Bool {
        return true
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(movieList, forKey: "movieList")
    }
}
