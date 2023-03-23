//
//  ViewController.swift
//  BoxOffice
//
//  Created by Rhode, Rilla on 2023/03/20.
//


import UIKit

class ViewController: UIViewController {
    
    let server = NetworkManager()
    let urlMaker = URLMaker()

    var movieInfoResult: DetailMovieInformation? 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let url = urlMaker.makeMovieInformationURL(movieCode: "20124079") else { return }
    
        server.startLoad(url: url) { result in
            let decoder = DecodeManager()
            
            switch result {
            case .success(let data):
                self.movieInfoResult = decoder.decodeJSON(data: data, type: DetailMovieInformation.self)
            case .failure(let error):
                print(error.localizedDescription)
            }
            
        }
        
    }


}

