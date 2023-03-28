//
//  ViewController.swift
//  BoxOffice
//
//  Created by kjs on 13/01/23.
//

import UIKit

final class ViewController: UIViewController {
    
    var movie = NetworkModel<DailyBoxofficeObject>(apiType: .boxoffice("20230324"), session: URLSession.shared )
    
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
        var giveTask = movie.giveTask()
        giveTask?.cancel()

    }
}
