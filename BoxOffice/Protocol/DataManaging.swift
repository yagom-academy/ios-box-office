//
//  DataManaging.swift
//  BoxOffice
//
//  Created by karen on 2023/07/26.
//

import Foundation

protocol DataManaging {
    func decodeJSON() -> [MovieInfo]?
    func loadData(named name: String) -> Data?
    func decodeData<MovieData: Decodable>(_ type: MovieData.Type, from data: Data) -> MovieData?
}
