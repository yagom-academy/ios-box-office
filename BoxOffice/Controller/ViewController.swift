//
//  ViewController.swift
//  BoxOffice
//
//  Created by goat, songjun on 13/01/23.
//

import UIKit

class ViewController: UIViewController {

    private var boxOffice: BoxOffice?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchBoxOffice()
        
    }
    
    func fetchBoxOffice() {
        boxOffice = BoxOfficeParser.boxOfficeParse()
        
        print(boxOffice?.boxOfficeResult.boxOfficeType)
    }
}

