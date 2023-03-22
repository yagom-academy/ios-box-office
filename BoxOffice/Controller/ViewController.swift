//
//  ViewController.swift
//  BoxOffice
//
//  Created by Christy, Hyemory on 2023/03/20.
//

import UIKit

class ViewController: UIViewController {
    let networking = NetworkManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        networking.fetchData()
    }
}
