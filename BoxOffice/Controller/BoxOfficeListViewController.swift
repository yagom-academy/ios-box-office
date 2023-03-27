//
//  BoxOfficeListViewController.swift
//  BoxOffice
//
//  Created by Rhode, Rilla on 2023/03/20.
//


import UIKit

final class BoxOfficeListViewController: UIViewController {
    private let server = NetworkManager()
    private let urlMaker = URLMaker()
    private var boxOffice: BoxOffice?
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 10
        
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        return collectionView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        configureView()
    }
    
    private func fetchBoxOfficeData() {
        guard let url = urlMaker.makeBoxOfficeURL(date: Date.configureYesterday(isFormatted: false)) else { return }
        server.startLoad(url: url) { result in
            let decoder = DecodeManager()
            
            guard let verifiedFetchingResult = self.verifyFetchingResult(result: result) else { return }
            let decodedFile = decoder.decodeJSON(data: verifiedFetchingResult, type: BoxOffice.self)
            let verifiedDecodingResult = self.verifyDecodingResult(result: decodedFile)
            
            self.boxOffice = verifiedDecodingResult
        }
    }
    
    private func verifyFetchingResult(result: Result<Data, NetworkError>) -> Data? {
        switch result {
        case .success(let data):
            return data
        case .failure(_):
            return nil
        }
    }
    
    private func verifyDecodingResult<T: Decodable>(result: Result<T, DecodeError>) -> T? {
        switch result {
        case .success(let data):
            return data
        case .failure(_):
            return nil
        }
    }
    
    private func configureView() {
        view.backgroundColor = .white
        self.title = Date.configureYesterday(isFormatted: true)
    }
}

extension BoxOfficeListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let count = boxOffice?.boxOfficeResult.dailyBoxOfficeList.count else { return 0 }
        
        return count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let dailyBoxOffice = self.boxOffice?.boxOfficeResult.dailyBoxOfficeList[indexPath.item]
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomCollectionViewCell", for: indexPath) as? CustomCollectionViewCell else { return CustomCollectionViewCell() }
        
        cell.configureDailyBoxOffice(dailyBoxOffice: dailyBoxOffice)
        
        return cell
    }
}

extension BoxOfficeListViewController: UICollectionViewDelegate {
    
}

extension BoxOfficeListViewController: UICollectionViewDelegateFlowLayout {
    
}
