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
                let information = try await NetworkManager.getMovieInformation(code: "20210672")
                print(information)
            } catch {
                print(error)
            }
        }
    }
}
