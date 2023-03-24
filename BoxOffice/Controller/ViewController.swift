//
//  ViewController.swift
//  BoxOffice
//
//  Created by goat, songjun on 13/01/23.
//

import UIKit

final class ViewController: UIViewController {
    private var boxOfficeAPI = BoxOfficeAPI()
    let abcLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        boxOfficeAPI.loadBoxOfficeAPI(urlAddress: URLAddress.movieDetailURL, parser: Parser<MovieDetail>()) {  data in
            print(data.movieInformationResult.movieInformation.movieCode)
        }
    }
}


