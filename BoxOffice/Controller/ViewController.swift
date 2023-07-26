//
//  ViewController.swift
//  BoxOffice
//
//  Created by kjs on 13/01/23.
//

import UIKit

final class ViewController: UIViewController {
    var apiProtocol: APIProtocol = GetDataAPI()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func requestAPI(completion: @escaping (Result<[MovieInfo], Error>) -> ()) {
        apiProtocol.callAPIServer(completion: completion)
    }
}

