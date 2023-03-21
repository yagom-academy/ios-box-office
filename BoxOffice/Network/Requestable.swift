//
//  Requestable.swift
//  BoxOffice
//
//  Created by 리지, kokkilE on 2023/03/21.
//

protocol Requestable {
    var url: String { get }
    var baseURL: String { get }
    var key: String { get }
}
