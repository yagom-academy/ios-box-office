//
//  DaumSearchMainText.swift
//  BoxOffice
//
//  Created by Serena, BMO on 2023/08/06.
//

struct DaumSearchMainText<Document: DaumSearchDocumentable>: Decodable {
    let meta: DaumSearchMeta
    let documents: [Document]
}
