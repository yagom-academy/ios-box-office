//
//  SampleData.swift
//  BoxOffice
//
//  Created by kaki, harry on 2023/03/23.
//

import UIKit

enum SampleData {
    var boxOfficeData: Data? {
        let asset = NSDataAsset(name: "BoxOffice")
        
        return asset?.data
    }
}
