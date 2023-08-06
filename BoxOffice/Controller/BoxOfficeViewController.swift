//
//  ViewController.swift
//  BoxOffice
//
//  Created by kjs on 13/01/23.
//

import UIKit

final class BoxOfficeViewController: UIViewController {
    private var dataManager = {
        guard let yesterday = Date.yesterday else {
            return DataManager(date: Date())
        }
        
        return DataManager(date: yesterday)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchBoxOfficeData()
    }
    
    private func fetchBoxOfficeData() {
        dataManager.boxOfficeDecoder.fetchData { [weak self] result in
            switch result {
            case .success(let data):
                self?.dataManager.movieItems = data.boxOfficeResult.movies
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

