//
//  BoxOfficeViewController.swift
//  BoxOffice
//
//  Created by kjs on 13/01/23.
//

import UIKit
import OSLog

class BoxOfficeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let networkManager = NetworkManager()
        
        networkManager.fetchData(url: KobisOpenAPI.boxOffice(targetDate: "20220102").url) { result in
            switch result {
            case .success(let data):
                do {
                    let decodedData = try DecodingManager.decodeJSON(type: BoxOffice.self, data: data)
                    print(decodedData)
                } catch DataError.notFoundAsset {
                    print(DataError.notFoundAsset.localizedDescription)
                } catch DataError.failedDecoding {
                    print(DataError.failedDecoding.localizedDescription)
                } catch {
                    os_log("알 수 없는 오류입니다.", type: .default)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
        networkManager.fetchData(url: KobisOpenAPI.movie(movieCode: "20124079").url) { result in
            switch result {
            case .success(let data):
                do {
                    let decodedData = try DecodingManager.decodeJSON(type: Movie.self, data: data)
                    print(decodedData)
                } catch DataError.notFoundAsset {
                    print(DataError.notFoundAsset.localizedDescription)
                } catch DataError.failedDecoding {
                    print(DataError.failedDecoding.localizedDescription)
                } catch {
                    os_log("알 수 없는 오류입니다.", type: .default)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
