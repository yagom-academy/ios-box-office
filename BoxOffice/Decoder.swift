//
//  Decoder.swift
//  BoxOffice
//
//  Created by Rhode, Rilla on 2023/03/20.
//


import Foundation
import UIKit

final class Decoder {
    
    private let decoder = JSONDecoder()
    private let fileName = "box_office_sample"

    func decodeBoxOfficeResult() -> BoxOfficeResult? {
        guard let dataAsset: NSDataAsset = NSDataAsset(name: fileName) else { return nil }
        
        do {
            let boxOfficeResult: BoxOfficeResult = try decoder.decode(BoxOfficeResult.self, from: dataAsset.data)
            return boxOfficeResult
        } catch {
            return nil
        }
    }
    
//    func decodeDailyBoxOffice(dailyBoxOfficeList: String) -> [DailyBoxOffice]? {
//        let encoder = JSONEncoder()
//
//        do {
//            let data = try encoder.encode(dailyBoxOfficeList)
//            let exposition: [DailyBoxOffice] = try decoder.decode([DailyBoxOffice].self, from: data)
//            return exposition
//        } catch {
//            return nil
//        }
//    }
}
