//
//  ViewController.swift
//  BoxOffice
//
//  Created by Rhode, Rilla on 2023/03/20.
//


import UIKit

class ViewController: UIViewController {
    
    private let server = NetworkManager()
    let urlMaker = URLMaker()

    private var boxOffice: BoxOffice?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    private func fetchBoxOfficeData() {
        guard let url = urlMaker.makeBoxOfficeURL(date: Date.yesterday) else { return }
        server.startLoad(url: url) { result in
            let decoder = DecodeManager()
            
            guard let verifiedFetchingResult = self.verifyFetchingResult(result: result) else { return }
            let decodedFile = decoder.decodeJSON(data: verifiedFetchingResult, type: BoxOffice.self)
            let verifiedDecodingResult = self.verifyDecodingResult(result: decodedFile)
            
            self.boxOffice = verifiedDecodingResult
        }
    }
    
    private func verifyFetchingResult(result: Result<Data, NetworkError>) -> Data? {
        switch result {
        case .success(let data):
            return data
        case .failure(_):
            return nil
        }
    }
    
    private func verifyDecodingResult<T: Decodable>(result: Result<T, DecodeError>) -> T? {
        switch result {
        case .success(let data):
            return data
        case .failure(_):
            return nil
        }
    }


}

