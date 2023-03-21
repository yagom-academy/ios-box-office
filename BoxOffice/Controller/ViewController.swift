//
//  ViewController.swift
//  BoxOffice
//
//  Created by Rhode, Rilla on 2023/03/20.
//


import UIKit

class ViewController: UIViewController {
    let decoder = Decoder()
    let server = ServerCommunication()
    let url = CommunicationForm.dailyBoxOffice + "20230320"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(url)
        server.startLoad(urlText: url) { data in
            let decodedData = self.decoder.decodeBoxOffice(data: data)
            print(decodedData?.boxOfficeResult.dailyBoxOfficeList)
        }
    }


}

