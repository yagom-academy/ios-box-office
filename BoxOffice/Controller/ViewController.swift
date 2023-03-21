//
//  ViewController.swift
//  BoxOffice
//
//  Created by Muri, Rowan on 13/01/23.
//

import UIKit

class ViewController: UIViewController, DataManagerDelegate {
    
    var dailyBoxOfficeData: DailyBoxOffice?
    var movieDetailsData: MovieDetails?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}

protocol DataManagerDelegate {
    var dailyBoxOfficeData: DailyBoxOffice? { get set }
    var movieDetailsData: MovieDetails? { get set }
}
