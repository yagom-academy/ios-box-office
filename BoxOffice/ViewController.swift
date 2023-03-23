//
//  ViewController.swift
//  BoxOffice
//
//  Created by kjs on 13/01/23.
//

import UIKit

final class ViewController: UIViewController {
    
    var movie = BoxofficeInfo<DailyBoxofficeObject>(apiType: .boxoffice("20230320"), session: URLSession.shared)
    
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
        movie.cancelTask()
    }
}
