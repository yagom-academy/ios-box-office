//
//  BoxOfficeViewController.swift
//  BoxOffice
//
//  Created by vetto, brody on 23/03/20.
//
import UIKit

final class BoxOfficeViewController: UIViewController {
    private var boxOffice: BoxOffice?
    private let networkManager = NetworkManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = BoxOfficeAPI.dailyBoxOffice(date: "20230320").url
        networkManager.fetchData(for: url, type: BoxOffice.self) { result in
            switch result {
            case .success(let data):
                print(data)
            case .failure(let error):
                let a = error
//                print(error)
            }
        }
    }
    
    func parseJson() {
        let jsonDecoder = BoxOfficeJsonDecoder()
        
        guard let jsonData: NSDataAsset = NSDataAsset(name: "box_office_sample") else {
            return
        }
        
        do {
            boxOffice = try jsonDecoder.decode(BoxOffice.self, from: jsonData.data)
        } catch {
            print(error.localizedDescription)
        }
    }
}

