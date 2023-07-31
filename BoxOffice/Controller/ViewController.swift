//
//  ViewController.swift
//  BoxOffice
//
//  Created by kjs on 13/01/23.
//  last modified by Idinaloq, MARY

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let url = KobisOpenAPI().receiveURL(serviceType: .dailyBoxOffice) else { return }
                
        NetworkManager.fetchData(url: url) { result in
            switch result {
            case .success(let data):
                do {
                    let decodedData = try JSONDecoder().decode(BoxOffice.self, from: data)
                    print(decodedData)
                } catch let error as DecodingError {
                    print(error)
                } catch {
                    print(error)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}

