//
//  DecodingHelper.swift
//  BoxOffice
//
//  Created by 박종화 on 2023/07/24.
//

import Foundation

struct DecodingHelper {
    
    func decode() -> BoxOffice? {
        let decoder = JSONDecoder()
        
        guard let path = Bundle.main.path(forResource: "box_office_sample", ofType: "json") else {
            print("해당 파일을 찾을 수 없습니다")
            return nil
        }
        
        guard let data = try? String(contentsOfFile: path).data(using: .utf8) else {
            print("해당 파일을 읽어 올 수 없습니다.")
            return nil
        }
        
        guard let result = try? decoder.decode(BoxOffice.self, from: data) else {
            print("해당 파일을 변환하는데 실패했습니다.")
            return nil
        }
        
        return result
    }
}
