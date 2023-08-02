//
//  ViewController.swift
//  BoxOffice
//
//  Created by kjs on 13/01/23.
//

import UIKit

final class ViewController: UIViewController {
    private let boxOfficeService = BoxOfficeService()
    private var boxOffice: BoxOffice?
    private var movie: Movie?
    
    // MARK: - CollecionView Configuratoin
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: view.frame.width, height: 100)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(BoxOfficeCell.self, forCellWithReuseIdentifier: BoxOfficeCell.identifier)
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configurateBackgroundColor()
        
        loadDailyBoxOfficeData()
    }
    
    private func configurateBackgroundColor() {
        view.backgroundColor = .systemBackground
    }
    
    private func loadDailyBoxOfficeData() {
        boxOfficeService.loadDailyBoxOfficeData(fetchBoxOffice)
    }
    
    private func fetchBoxOffice(_ result: Result<BoxOffice, NetworkManagerError>) {
        switch result {
        case .success(let boxOffice):
            print(boxOffice)
            self.boxOffice = boxOffice
            if let movieCode = boxOffice.boxOfficeResult.dailyBoxOfficeList.first?.movieCode {
                boxOfficeService.loadMovieDetailData(movieCd: movieCode, fetchMovie)
            }
        case .failure(let error):
            print(error)
        }
    }

    private func fetchMovie(_ result: Result<Movie, NetworkManagerError>) {
        switch result {
        case .success(let movie):
            print(movie)
            self.movie = movie
        case .failure(let error):
            print(error)
        }
    }
}

// MARK: - CollectionView DataSource
extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        boxOffice?.boxOfficeResult.dailyBoxOfficeList.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BoxOfficeCell.identifier, for: indexPath) as? BoxOfficeCell else {
            return UICollectionViewCell()
        }

        return cell
    }
}

// MARK: CollectionView Delegate
extension ViewController: UICollectionViewDelegate {

}
