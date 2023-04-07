//
//  DummyBoxOffice.swift
//  NetworkManagerTests
//
//  Created by Rhode, Rilla on 2023/03/30.
//

import UIKit

struct DummyBoxOffice {
    var data: Data {
        return NSDataAsset(name: "box_office_sample")!.data
    }
}
