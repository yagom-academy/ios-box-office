//
//  ViewController.swift
//  BoxOffice
//
//  Created by goat, songjun on 13/01/23.
//

import UIKit

class ViewController: UIViewController {

    private var boxOffice: BoxOffice?
    private let boxOfficeParser = BoxOfficeParser()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchBoxOffice()
        
    }
    
    func fetchBoxOffice() {
        boxOffice = boxOfficeParser.boxOfficeParse()
        
        print(boxOffice?.boxOfficeResult.boxOfficeType)
        print(boxOffice?.boxOfficeResult.dailyBoxOfficeList[1].movieNm)
    }
}

