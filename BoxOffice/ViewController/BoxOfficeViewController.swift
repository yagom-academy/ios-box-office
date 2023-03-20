//
//  BoxOfficeViewController.swift
//  BoxOffice
//
//  Created by vetto, brody on 23/03/20.
//

import UIKit

final class BoxOfficeViewController: UIViewController {
    private var boxOfficeResult: BoxOfficeResult?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        parseJson()
    }
    
    func parseJson() {
        let jsonDecoder = BoxOfficeJsonDecoder()
        
        guard let jsonData: NSDataAsset = NSDataAsset(name: "box_office_sample") else {
            return
        }
        
        do {
            boxOfficeResult = try jsonDecoder.decode(BoxOfficeResult.self, from: jsonData.data)
        } catch {
            print(error.localizedDescription)
        }
    }
}

