//
//  ViewController.swift
//  BoxOffice
//
//  Created by Christy, Hyemory on 2023/03/20.
//

import UIKit

class ViewController: UIViewController {
    var boxOffice: BoxOffice? = nil
    let networking = NetworkManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.networking.fetchData(type: BoxOffice.self) { result in
            switch result {
            case .success(let boxOffice):
                self.boxOffice = boxOffice
            case .failure(let error):
                print(error)
                return
            }
        }
    }
}
