//
//  ImageDocument.swift
//  BoxOffice
//
//  Created by EtialMoon, Minsup on 2023/08/08.
//

struct ImageDocument: Decodable {
    let imageURL: String
    
    private enum CodingKeys: String, CodingKey {
        case imageURL = "image_url"
    }
}
