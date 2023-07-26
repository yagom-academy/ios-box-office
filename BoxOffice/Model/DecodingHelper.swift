//
//  DecodingHelper.swift
//  BoxOffice
//
//  Created by redmango, Jusbug on 2023/07/24.
//

import Foundation

struct DecodingHelper<T:Decodable> {
    
    func parse(from fileName: String) throws -> T {
        let path = try getJsonFile(by: fileName)
        let data = try getJsonData(path: path)
        let decodedData = try decode(from: data)
        
        return decodedData
    }

    private func getJsonFile(by name: String) throws -> String {
        guard let path = Bundle.main.path(forResource: name, ofType: "json") else {
            throw JSONDecodingError.missingFile
        }
        
        return path
    }
    
    private func getJsonData(path: String) throws -> Data {
        guard let data = try? String(contentsOfFile: path).data(using: .utf8) else {
            throw JSONDecodingError.unreadableData
        }
        
        return data
    }
    
    private func decode(from data: Data) throws -> T {
        let decoder = JSONDecoder()

        guard let result = try? decoder.decode(T.self, from: data) else {
            throw JSONDecodingError.undecodableData
        }
        
        return result
    }
}

enum JSONDecodingError: LocalizedError {
    case missingFile
    case unreadableData
    case undecodableData
    
    var errorDescription: String? {
        switch self {
            
        case .missingFile:
            return "해당 파일을 찾을 수 없습니다"
        case .unreadableData:
            return "해당 파일을 읽어 올 수 없습니다."
        case .undecodableData:
            return "해당 파일을 변환하는데 실패했습니다."
        }
    }
}
