//
//  ViewController.swift
//  BoxOffice
//
//  Created by goat, songjun on 13/01/23.
//

import UIKit

final class BoxOfficeViewController: UIViewController {
    
    @IBOutlet weak var boxOfficeListCollectionView: UICollectionView!
    
    private var parsedMovieDetail: MovieDetail?
    private var parsedDailyBoxOffice: DailyBoxOffice?
    
    private let dailyBoxOfficeParser = Parser<DailyBoxOffice>()
    private let movieDetailParser = Parser<MovieDetail>()
    
    private var boxOfficeAPI = BoxOfficeAPI()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        boxOfficeAPI.delegate = self
    }
    
    private func configureUI() {
        let safeArea = view.safeAreaLayoutGuide
    
        boxOfficeListCollectionView.translatesAutoresizingMaskIntoConstraints = false
    
        view.addSubview(boxOfficeListCollectionView)
        
        NSLayoutConstraint.activate([
            boxOfficeListCollectionView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            boxOfficeListCollectionView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            boxOfficeListCollectionView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            boxOfficeListCollectionView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor)
        ])
    }
}

extension BoxOfficeViewController: BoxOfficeAPIDelegate {
    func fetchAPIData<T>(data: T) where T : Decodable {
    
        switch data {
        case is MovieDetail:
            parsedMovieDetail = data as? MovieDetail
        case is DailyBoxOffice:
            parsedDailyBoxOffice = data as? DailyBoxOffice
        default:
            return
        }
    }
}


