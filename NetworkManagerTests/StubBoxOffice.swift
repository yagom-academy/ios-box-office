//
//  StubBoxOffice.swift
//  NetworkManagerTests
//
//  Created by 김성준 on 2023/03/30.
//

//import Foundation
import UIKit

struct StubBoxOffice {
    var data: Data {
        return NSDataAsset(name: "box_office_sample")!.data
    }
}
