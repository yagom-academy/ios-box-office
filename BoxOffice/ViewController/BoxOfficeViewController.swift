//
//  BoxOfficeViewController.swift
//  BoxOffice
//
//  Created by vetto, brody on 23/03/20.
//
import UIKit

final class BoxOfficeViewController: UIViewController {
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
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.center = self.view.center
        activityIndicator.frame = view.frame
        activityIndicator.style = UIActivityIndicatorView.Style.large
        activityIndicator.startAnimating()
        return activityIndicator
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        self.fetchDailyBoxOffice()
    }
    
    func setupUI() {
        self.view.backgroundColor = .white
        self.view.addSubview(activityIndicator)
    }
    
    private func fetchDailyBoxOffice() {
        guard let yesterday = yesterday else {
            return
        }
        
        let boxOfficeProvider = BoxOfficeProvider<BoxOfficeAPI>()
        boxOfficeProvider.fetchData(.dailyBoxOffice(date: yesterday),
                                    type: BoxOfficeDTO.self) { result in
            switch result {
            case .success:
                DispatchQueue.main.async {
                    self.activityIndicator.stopAnimating()
                }
            case .failure:
                DispatchQueue.main.async {
                    self.activityIndicator.stopAnimating()
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

