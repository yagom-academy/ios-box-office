//
//  Image.swift
//  BoxOffice
//
//  Created by EtialMoon, Minsup on 2023/08/08.
//

struct Image: Decodable {
    let imageDocuments: [ImageDocument]
    
    private enum CodingKeys: String, CodingKey {
        case imageDocuments = "documents"
    }
}
