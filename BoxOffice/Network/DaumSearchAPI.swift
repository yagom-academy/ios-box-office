//
//  DaumSearchAPI.swift
//  BoxOffice
//
//  Created by Muri, Rowan on 2023/03/29.
//

import UIKit

final class DaumSearchAPI: API {
    var baseURL: String {
        return "https://dapi.kakao.com/v2"
    }
    
    var path: String {
        return "/search/image"
    }
    
    var queries: [String : String] = [:]
    
    var headers = ["Authorization": "KakaoAK a8067f99f3c8ff86ab9e4d096a6e9aab"]

    var sampleData: Data?
}
