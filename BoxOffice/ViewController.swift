//
//  ViewController.swift
//  BoxOffice
//
//  Created by kjs on 13/01/23.
//

import UIKit

final class ViewController: UIViewController {
    let boxOfficeInfo = BoxofficeInfo<DailyBoxofficeObject>(apiType: .boxoffice("20230325"), model: NetworkModel(session: URLSession.shared) )
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        boxOfficeInfo.fetchData { result in
            switch result {
            case .success(let data):
                print(data)
            case .failure(let error):
                print(error)
            }
        }
    }
}
