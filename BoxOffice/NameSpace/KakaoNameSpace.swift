//
//  KakaoNameSpace.swift
//  BoxOffice
//
//  Created by Serena, BMO on 2023/08/08.
//

import Foundation

enum KakaoNameSpace {
    static let scheme = "https"
    static let host = "dapi.kakao.com"
    static let path = "/v2/search/image"
    static let query = "query"
    static let size = "size"
    static let one = "1"
    static let authorization = "Authorization"
    static let apiKey = Bundle.main.kakaoApiKey
}
