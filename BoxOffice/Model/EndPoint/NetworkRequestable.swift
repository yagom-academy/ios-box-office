//
//  NetworkRequestable.swift
//  BoxOffice
//
//  Created by 리지, kokkilE on 2023/03/22.
//

import Foundation

protocol NetworkRequestable {
    var urlRequest: URLRequest? { get }
    var url: URL? { get }
    
    mutating func setEndPoint(method: HttpMethod, body: Data?, baseURL: String, key: String, targetDate: String, itemPerPage: String?, multiMovieType: MovieType?, nationCode: NationalCode?, wideAreaCode: String?)
    mutating func setEndPoint(method: HttpMethod, body: Data?, baseURL: String, key: String, movieCode: String)
}
