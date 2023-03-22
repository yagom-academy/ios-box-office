//
//  StubBoxoffice.swift
//  BoxofficeInfoTests
//
//  Created by Andrew, 레옹아범 on 2023/03/22.
//

import UIKit

struct StubBoxoffice {
    var data: Data {
        return NSDataAsset(name: "box_office_sample")!.data
    }
}
