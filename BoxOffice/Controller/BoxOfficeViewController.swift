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
        boxOfficeListCollectionView.delegate = self
        boxOfficeListCollectionView.dataSource = self
        configureUI()
        configureRefreshControl()
    }
    
    private func configureUI() {
        self.title = "2023123"
    
        let safeArea = view.safeAreaLayoutGuide
        
        boxOfficeListCollectionView.translatesAutoresizingMaskIntoConstraints = false
    
//        view.addSubview(boxOfficeListCollectionView)
        
        NSLayoutConstraint.activate([
            boxOfficeListCollectionView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            boxOfficeListCollectionView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            boxOfficeListCollectionView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            boxOfficeListCollectionView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor)
        ])
    }
    
    func configureRefreshControl() {
       // Add the refresh control to your UIScrollView object.
        boxOfficeListCollectionView.refreshControl = UIRefreshControl()
        boxOfficeListCollectionView.refreshControl?.addTarget(self, action:
                                          #selector(handleRefreshControl),
                                          for: .valueChanged)
    }
    
    @objc func handleRefreshControl() {
        DispatchQueue.main.async {
            self.boxOfficeListCollectionView.reloadData()
            self.boxOfficeListCollectionView.refreshControl?.endRefreshing()
        }
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

extension BoxOfficeViewController: UICollectionViewDelegate {
    
}

extension BoxOfficeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cellId = String(describing: BoxOfficeListCell.self)
        let cell = boxOfficeListCollectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! BoxOfficeListCell
        
        cell.configureUI()
        
        return cell
    }
}


extension BoxOfficeViewController: UICollectionViewDelegateFlowLayout {
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//
//        return CGSize(width: width, height: height / 9)
//    }

}
