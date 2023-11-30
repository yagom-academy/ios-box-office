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
        print(RequestUrl.dailyBoxOffice)
        print(RequestUrl.searchMovieInfo(movieCode: "20124079"))
    }


}

