//
//  RequestMethod.swift
//  BoxOffice
//
//  Created by 리지, kokkilE on 2023/03/22.
//

enum RequestMethod {
    case get
    
    var description: String {
        switch self {
        case .get:
            return "GET"
        }
    }
}
