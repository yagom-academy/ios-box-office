//
//  BoxOfficeViewController.swift
//  BoxOffice
//
//  Created by vetto, brody on 23/03/20.
//

import UIKit

final class BoxOfficeViewController: UIViewController {
    private var boxOffice: BoxOffice?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        parseJson()
        print(boxOffice)
    }
    
    func parseJson() {
        let jsonDecoder = BoxOfficeJsonDecoder()
        
        guard let jsonData: NSDataAsset = NSDataAsset(name: "box_office_sample") else {
            return
        }
        
        do {
            boxOffice = try jsonDecoder.decode(BoxOffice.self, from: jsonData.data)
        } catch {
            print(error.localizedDescription)
        }
    }
}

