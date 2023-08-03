//
//  ViewController.swift
//  BoxOffice
//
//  Created by EtialMoon, Minsup on 13/01/23.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad()  {
        super.viewDidLoad()
        
        Task {
            do {
                let information: BoxOffice = try await NetworkManager.fetchData(fetchType: .boxOffice(date: "20230727"))
                print(information)
            } catch {
                print(error)
            }
        }
    }
}
