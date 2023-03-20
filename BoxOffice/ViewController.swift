//
//  ViewController.swift
//  BoxOffice
//
//  Created by Rhode, Rilla on 2023/03/20.
//


import UIKit

class ViewController: UIViewController {
    let decoder = Decoder()
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let boxOfficeResult = decoder.decodeBoxOfficeResult() else { return }
        print(boxOfficeResult.dailyBoxOfficeList.count)
        print("hi")
    }


}

