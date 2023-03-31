//
//  DecodeManager.swift
//  BoxOffice
//
//  Created by Rhode, Rilla on 2023/03/20.
//

import UIKit

final class DecodeManager {
    private let decoder = JSONDecoder()
    
    func decodeJSON<T: Decodable>(fileName: String, type: T.Type) -> Result<T, DecodeError> {
        
        guard let JSONFile: NSDataAsset  = NSDataAsset(name: fileName) else {
            return .failure(.invalidFileError)
        }
        
        do{
            let decodedJSON: T = try decoder.decode(type, from: JSONFile.data)
            return .success(decodedJSON)
        } catch {
            return .failure(.decodingFailureError)
        }
    }
    
    func decodeJSON<T: Decodable>(data: Data, type: T.Type) -> Result<T, DecodeError> {
        
        guard let decodedJSON: T = try? decoder.decode(type, from: data) else { return .failure(.decodingFailureError) }
        
        return .success(decodedJSON)
    }
}
