//
//  NetworkError.swift
//  BoxOffice
//
//  Created by 리지, kokkilE on 2023/03/22.
//

enum NetworkError: Error, CustomStringConvertible {
    case invalidURL
    case unknown
    case reponseStatusCode
    case decode
    
    var description: String {
        switch self{
        case .invalidURL:
            return "Invalid URL"
        case .unknown:
            return "Unknown Error"
        case .reponseStatusCode:
            return "Response Status Code Error"
        case .decode:
            return "Decode Error"
        }
    }
}
