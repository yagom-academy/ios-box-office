//
//  EndPoint.swift
//  BoxOffice
//
//  Created by Kobe, yyss99 on 2023/08/01.
//

public struct EndPoint: NetworkConfigurable {
    public var baseURL: String
    public var queryItems: [String : String]?
}
