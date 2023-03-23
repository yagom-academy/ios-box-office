//
//  Decoder.swift
//  BoxOffice
//
//  Created by 리지, kokkilE on 2023/03/21.
//

import UIKit

enum Decoder {
   static func parseJSON<element: Decodable>(_ data: Data, returnType: element.Type) -> element? {       
       do {
           let jsonDecoder = JSONDecoder()
           let result = try jsonDecoder.decode(returnType, from: data)
           return result
       } catch {
           return nil
       }
   }
}
