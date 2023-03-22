//
//  ViewController.swift
//  BoxOffice
//
//  Created by Seoyeon Hong on 2023/03/22.
//

import UIKit

class ViewController: UIViewController {
    
    let targetDate = "20220301"
    let movieCode = "20124079"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchBoxOfficeData()
        fetchMovieDetailData()
    }

    func fetchBoxOfficeData() {
        URLSessionProvider.shared.performRequest(api: .boxOffice(date: targetDate)) { requestResult in
            switch requestResult {
            case .success(let data):
                do {
                    let boxOfficeItem: BoxOfficItem = try JSONConverter.shared.decodeData(data, T: BoxOfficItem.self)
                    let myMovielists = boxOfficeItem.boxOfficeResult.dailyBoxOfficeList
                    for movie in myMovielists {
                        print(movie)
                    }
                } catch let error as NetworkError {
                    print(error.description)
                } catch {
                    print("Unexpected error: \(error)")
                }
                
            case .failure(let error):
                print(error)
            }
        }
    }

    func fetchMovieDetailData() {
        URLSessionProvider.shared.performRequest(api: .detail(code: movieCode)) { requestResult in
            switch requestResult {
            case .success(let data):
                do {
                    let movieInfo: MovieInfo = try JSONConverter.shared.decodeData(data, T: MovieInfo.self)
                    print(movieInfo)
                } catch let error as NetworkError {
                    print(error.description)
                } catch {
                    print("Unexpected error: \(error)")
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
}
