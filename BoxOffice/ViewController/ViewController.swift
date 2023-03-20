//
//  ViewController.swift
//  BoxOffice
//
//  Created by vetto, brody on 23/03/20.
//

import UIKit

class ViewController: UIViewController {
    
    private var boxOfficeResult: BoxOfficeResult?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        parse()
        print(boxOfficeResult)
    }
    func parse() {
        let jsonDecoder = JSONDecoder()
        
        guard let jsonData: NSDataAsset = NSDataAsset(name: "box_office_sample") else {
            return
        }
        
        do {
            print("\(jsonData.data)")
            boxOfficeResult = try jsonDecoder.decode(BoxOfficeResult.self, from: jsonData.data)
            print(jsonData.data)
        } catch {
            print(error)
            return
        }
    }
}

