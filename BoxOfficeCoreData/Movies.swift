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
    
    init(boxOfficeDatas: [Movie]) {
        self.movieList = boxOfficeDatas
    }
    
    convenience required init?(coder: NSCoder) {
        let boxOfficeDatas = coder.decodeObject(of: [NSArray.self, Movie.self], forKey: "movieList")
        
        self.init(boxOfficeDatas: boxOfficeDatas as! [Movie])
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
