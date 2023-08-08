//
//  DailyBoxOfficeViewController.swift
//  BoxOffice
//
//  Created by kjs on 13/01/23.
//  last modified by Idinaloq, MARY

import UIKit

final class DailyBoxOfficeViewController: UIViewController {
    private var kobisOpenAPI: KobisOpenAPI = KobisOpenAPI()
    private var networkService: NetworkService = NetworkService()
    private var dateManager: DateManager = DateManager()
    private var boxOfficeData: BoxOffice?
    
    private lazy var refreshControl: UIRefreshControl = {
        let refreshControl: UIRefreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshCollectionView), for: .valueChanged)
        
        return refreshControl
    }()
    
    private let collectionView: UICollectionView = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        let collectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        layout.minimumLineSpacing = 0
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        return collectionView
    }()
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
        activityIndicator.center = self.view.center
        activityIndicator.color = .systemRed
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = .large
        activityIndicator.startAnimating()
        activityIndicator.layer.zPosition = 1
        
        return activityIndicator
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationItem()
        setupCollectionView()
        configureView()
        setUpAutoLayout()
        receiveData()
    }
    
    private func receiveURL() -> URL? {
        do {
            let url = try kobisOpenAPI.receiveURL(serviceType: .dailyBoxOffice, queryItems: ["targetDt": dateManager.getYesterdayDate(format: "yyyyMMdd")])
            return url
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
    
    private func decodeData(_ data: Data) {
        do {
            let decodedData = try JSONDecoder().decode(BoxOffice.self, from: data)
            boxOfficeData = decodedData
        } catch let error as DecodingError {
            print(error)
        } catch {
            print(error)
        }
    }
    
    private func reloadCollectionView() {
        DispatchQueue.main.async { [weak self] in
            self?.activityIndicator.stopAnimating()
            self?.collectionView.reloadData()
        }
    }
    
    @objc func refreshCollectionView() {
        receiveData()
        
        DispatchQueue.main.async { [weak self] in
            self?.refreshControl.endRefreshing()
        }
        
    }
    
    private func configureNavigationItem() {
        navigationItem.title = dateManager.getYesterdayDate(format: "yyyy-MM-dd")
    }
    
    private func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(DailyBoxOfficeCollectionViewCell.self,
                                forCellWithReuseIdentifier: DailyBoxOfficeCollectionViewCell.identifier)
        collectionView.refreshControl = refreshControl
    }
    
    private func configureView() {
        view.addSubview(activityIndicator)
        view.addSubview(collectionView)
        view.backgroundColor = .systemBackground
    }
    
    private func setUpAutoLayout() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func receiveData() {
        guard let url = receiveURL() else { return }
        
        NetworkService().fetchData(url: url) { result in
            switch result {
            case .success(let data):
                self.decodeData(data)
                self.reloadCollectionView()
            case .failure(let error):
                print(error)
            }
        }
    }
}

extension DailyBoxOfficeViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DailyBoxOfficeCollectionViewCell.identifier, for: indexPath) as? DailyBoxOfficeCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        guard let data = boxOfficeData,
              let data = data.boxOfficeResult.dailyBoxOfficeList[index: indexPath.item] else {
            return cell
        }
        
        cell.configureCell(data: data)

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = collectionView.frame.width
        var height: CGFloat = collectionView.frame.height * 0.1

        guard let data = boxOfficeData,
              let data = data.boxOfficeResult.dailyBoxOfficeList[index: indexPath.item] else {
            return CGSize(width: width, height: height)
        }
        
        let cell = DailyBoxOfficeCollectionViewCell(frame: CGRect(x: 0, y: 0, width: width, height: height))
        
        cell.titleLabel.text = data.movieName
        cell.setNeedsLayout()
        cell.layoutIfNeeded()
        
        let titleLabelSize = cell.titleLabel.intrinsicContentSize
        
        height += titleLabelSize.height

        return CGSize(width: width, height: height)        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let data = boxOfficeData,
              let data = data.boxOfficeResult.dailyBoxOfficeList[index: indexPath.item] else {
            return
        }
        
        let movieInformationViewController: MovieInformationViewController = MovieInformationViewController(data: data)
        
        collectionView.deselectItem(at: indexPath, animated: true)
        
        navigationController?.pushViewController(movieInformationViewController, animated: true)
    }
}
