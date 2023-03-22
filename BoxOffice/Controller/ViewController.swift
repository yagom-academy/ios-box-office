//
//  ViewController.swift
//  BoxOffice
//
//  Created by Rhode, Rilla on 2023/03/20.
//


import UIKit

class ViewController: UIViewController {
    //let decoder = Decoder()
    let server = NetworkManager()
    let url = CommunicationForm.dailyBoxOffice + "20230320"
    let anotherURL = CommunicationForm
        .detailMovieInformation + "20124079"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        server.startLoad(urlText: anotherURL) { data in
            //다운로드 후 해야할 작업
        }
    }


}

