//
//  JsonLoader.swift
//  BoxOffice
//
//  Created by vetto, brody on 23/03/22.
//

import Foundation
import UIKit

final class JsonLoader {
    static func loadJsonAsset(name: String) -> Data? {
        guard let asset = NSDataAsset(name: "box_office_sample") else {
            return nil
        }
        return asset.data
    }
}
