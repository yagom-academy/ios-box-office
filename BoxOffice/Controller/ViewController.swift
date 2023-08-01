//
//  ViewController.swift
//  BoxOffice
//
//  Created by kjs on 13/01/23.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        printBoxOfficeData()
    }
}

extension ViewController {
    func printBoxOfficeData() {
        do {
            
            let endPoint = EndPoint(
                baseURL: "http://kobis.or.kr",
                queryItems: [
                    "key": "d4bb1f8d42a3b440bb739e9d49729660",
                    "targetDt": "20230724"
                ]
            )
            
            let url = try endPoint.generateURL(
                paths: [
                    "/kobisopenapi",
                    "/webservice",
                    "/rest",
                    "/boxoffice",
                    "/searchDailyBoxOfficeList.json"
                ],
                isFullPath: false
            )
            
            let urlRequest = URLRequest(url: url)
            
            let networkManager = NetworkManager()
            networkManager.getBoxOfficeData(requestURL: urlRequest) { (boxOffice: BoxOffice) in
                print(boxOffice)
            }
            
        } catch {
            print(error.localizedDescription)
        }
    }
}
