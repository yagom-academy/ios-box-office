//
//  BoxOfficeViewController.swift
//  BoxOffice
//
//  Created by vetto, brody on 23/03/20.
//
import UIKit

final class BoxOfficeViewController: UIViewController {
    private var boxOffice: BoxOffice?
    private var movieInformation: MovieInformation?
    private let networkManager = NetworkManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchDailyBoxOffice()
        fetchDetailMovieInformation()
    }
    
    private func fetchDailyBoxOffice() {
        guard let yesterdayDate = Calendar.current.date(
            byAdding: Calendar.Component.day,
            value: -1,
            to: Date()) else {
            return
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyymmdd"
        let yesterday = dateFormatter.string(from: yesterdayDate)
        
        let url = BoxOfficeAPI.dailyBoxOffice(date: yesterday).url
        networkManager.fetchData(for: url, type: BoxOffice.self) { result in
            switch result {
            case .success(let boxOffice):
                self.boxOffice = boxOffice
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func fetchDetailMovieInformation() {
        let url = BoxOfficeAPI.detailMovieInformation(movieCode: "20124080").url
        networkManager.fetchData(for: url, type: MovieInformation.self) { result in
            switch result {
            case .success(let movieInformation):
                self.movieInformation = movieInformation
            case .failure(let error):
                print(error)
            }
        }
    }
}

