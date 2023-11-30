//
//  ViewController.swift
//  BoxOffice
//
//  Created by kjs on 13/01/23.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(RequestURL.dailyBoxOffice.getURL(movieCode: nil))
        print(RequestURL.movieInfo.getURL(movieCode: "1234"))
    }


}

