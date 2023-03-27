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
    private let movieCode = "20124080"
    
    private var yesterday: String? {
        guard let yesterdayDate = Calendar.current.date(
            byAdding: Calendar.Component.day,
            value: -1,
            to: Date()) else {
            return nil
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd"
        let yesterday = dateFormatter.string(from: yesterdayDate)
            
        return yesterday
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.fetchDailyBoxOffice()
    }
    
    private func fetchDailyBoxOffice() {
        guard let yesterday = yesterday else {
            return
        }
        
        let boxOfficeProvider = BoxOfficeProvider<BoxOfficeAPI>()
        boxOfficeProvider.fetchData(.dailyBoxOffice(date: yesterday), type: BoxOffice.self) { result in
            switch result {
            case .success(let boxOffice):
                self.boxOffice = boxOffice
            case .failure(_):
                DispatchQueue.main.async {
                    self.showAlert()
                }
            }
        }
    }
    
    private func showAlert() {
        let alert = UIAlertController(
            title: "에러",
            message: "데이터를 불러올 수 없습니다",
            preferredStyle: .alert
        )
        let okAction = UIAlertAction(title: "확인", style: .default)
        
        alert.addAction(okAction)
        
        present(alert, animated: true)
    }
}

