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

    var datamanager = DataManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        datamanager.delegate = self

    }
}

protocol DataManagerDelegate {
    var dailyBoxOfficeData: DailyBoxOffice? { get set }
    var movieDetailsData: MovieDetails? { get set }
}
