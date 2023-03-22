//
//  DecodeManager.swift
//  BoxOffice
//
//  Created by Rhode, Rilla on 2023/03/20.
//

import UIKit

final class DecodeManager<T: Decodable> {
    
    private let decoder = JSONDecoder()
   

    func decodeDataAsset(fileName: String) -> Result<T, DecodeError> {
        
        guard let JSONFile: NSDataAsset  = NSDataAsset(name: fileName) else {
            return .failure(.invalidFileError)
        }
        
        do{
            let decodedJSON: T = try decoder.decode(T.self, from: JSONFile.data)
            return .success(decodedJSON)
        } catch {
            return .failure(.decodingFailureError)
        }
        
    }
}
