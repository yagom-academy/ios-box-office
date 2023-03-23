//
//  ViewController.swift
//  BoxOffice
//
//  Created by kjs on 13/01/23.
//

import UIKit

final class ViewController: UIViewController {
    
    let movie = BoxofficeInfo<DailyBoxofficeObject>(apiType: .boxoffice("20230320"))
    
    override func viewDidLoad() {
        super.viewDidLoad()

        movie.search { event in
            switch event {
            case .success(let data):
                print(data)
            case .failure(let error):
                print(error)
            }
        }
        
    }


}
