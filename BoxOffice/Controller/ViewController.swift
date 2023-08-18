//
//  ViewController.swift
//  BoxOffice
//
//  Created by 훈민트 on 2023/08/16.
//

import UIKit

class ViewController: UIViewController {
    let boxOffice = Model(networkManager: NetworkManager(), type: BoxOfficeData(), apiKey: URLQueryItem(name: "key", value: "f5eef3421c602c6cb7ea224104795888"), queryItems: ["targetDt": "20120101"])
    override func viewDidLoad() {
        super.viewDidLoad()
        boxOffice.fetch()
    }
}
