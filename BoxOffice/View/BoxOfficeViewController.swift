//
//  BoxOfficeViewController.swift
//  BoxOffice
//
//  Created by kaki, harry on 2023/03/20.
//

import UIKit

final class BoxOfficeViewController: UIViewController {
    @IBOutlet private weak var collectionView: UICollectionView!
    
    private let boxOfficeDataLoader = BoxOfficeDataLoader()
    private let refreshControl = UIRefreshControl()
    private var boxOffice: BoxOffice?
    private var selectedDate = Date(timeIntervalSinceNow: -86400) {
        didSet {
            navigationItem.title = DateFormatter.hyphenText(date: selectedDate)
            loadData()
        }
    }
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.style = UIActivityIndicatorView.Style.large
        activityIndicator.center = self.view.center
        
        return activityIndicator
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureInitialView()
        loadData()
    }
    
<<<<<<< HEAD:BoxOffice/Controller/BoxOfficeViewController.swift
    private func configureInitialView() {
        navigationItem.title = DateFormatter.hyphenText(date: selectedDate)
        self.view.addSubview(activityIndicator)
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        configureCollectionView()
    }
    
    private func loadData() {
        activityIndicator.startAnimating()
        
        fetchDailyBoxOffice { [weak self] in
            guard let self = self else { return }
            
            self.activityIndicator.stopAnimating()
=======
    @objc private func refreshData() {
        loadData { [weak self] in
            self?.refreshControl.endRefreshing()
        }
    }
    
    private func loadInitialData() {
        activityIndicator.startAnimating()
        
        loadData { [weak self] in
            self?.activityIndicator.stopAnimating()
        }
    }
    
    private func loadData(completion: @escaping () -> ()) {
        boxOfficeDataLoader.loadDailyBoxOffice { boxOffice, error in
            DispatchQueue.main.async { [weak self] in
                guard let error = error else {
                    self?.boxOffice = boxOffice
                    self?.collectionView.reloadData()
                    completion()
                    return
                }
                
                self?.showFailAlert(error: error)
                completion()
            }
>>>>>>> step4:BoxOffice/View/BoxOfficeViewController.swift
        }
    }
    
    private func registerXib() {
        let nibName = UINib(nibName: BoxOfficeCollectionViewListCell.identifier, bundle: nil)
        collectionView.register(nibName, forCellWithReuseIdentifier: BoxOfficeCollectionViewListCell.identifier)
    }
    
    private func createListLayout() -> UICollectionViewCompositionalLayout {
        var config = UICollectionLayoutListConfiguration(appearance: .plain)
        config.separatorConfiguration.bottomSeparatorInsets = .init(top: 0, leading: 0, bottom: 0, trailing: 0)
        
        return UICollectionViewCompositionalLayout.list(using: config)
    }

    private func configureCollectionView() {
        collectionView.refreshControl = refreshControl
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.collectionViewLayout = createListLayout()
        registerXib()
    }
    
<<<<<<< HEAD:BoxOffice/Controller/BoxOfficeViewController.swift
    private func fetchDailyBoxOffice(completion: @escaping () -> Void) {
        let nonHyphenText = DateFormatter.nonHyphenText(date: selectedDate)
        let endPoint: BoxOfficeEndpoint = .fetchDailyBoxOffice(targetDate: nonHyphenText)
        
        networkManager.fetchData(request: endPoint.createRequest(), type: BoxOffice.self) {
            result in
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                
                switch result {
                case .success(let data):
                    self.boxOffice = data
                    self.collectionView.reloadData()
                case .failure(let error):
                    print(error.localizedDescription)
                    self.showFailAlert(error: error)
                }
                completion()
            }
        }
    }
    
    @objc private func refreshData() {
        fetchDailyBoxOffice { [weak self] in
            guard let self = self else { return }
            
            self.refreshControl.endRefreshing()
        }
    }
    
    @IBAction private func chooseDateButtonTapped(_ sender: UIBarButtonItem) {
        if let calendarVC = storyboard?.instantiateViewController(identifier: CalendarViewController.identifier, creator: {
            [weak self] creator in
            guard let self = self else { return UIViewController() }
            let viewController = CalendarViewController(date: self.selectedDate, coder: creator)
            viewController?.dateDelegate = self
            
            return viewController
        }) {
            self.present(calendarVC, animated: true)
        }
=======
    private func configureInitialView() {
        navigationItem.title = DateFormatter.yesterdayText(format: .hyphen)
        self.view.addSubview(activityIndicator)
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        configureCollectionView()
>>>>>>> step4:BoxOffice/View/BoxOfficeViewController.swift
    }
}

extension BoxOfficeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let count = boxOffice?.boxOfficeResult.dailyBoxOfficeList.count else { return 0 }
        
        return count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: BoxOfficeCollectionViewListCell.identifier,
            for: indexPath) as? BoxOfficeCollectionViewListCell,
                let item = boxOffice?.boxOfficeResult.dailyBoxOfficeList[safe: indexPath.item] else {
            return UICollectionViewCell()
        }
        
        cell.configure(item: item)
        
        return cell
    }
}

extension BoxOfficeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let movieInfoVC = storyboard?.instantiateViewController(identifier: MovieInfoViewController.identifier, creator: { creator in
            let movieCode = self.boxOffice?.boxOfficeResult.dailyBoxOfficeList[safe: indexPath.item]?.movieCodeText
            let movieName = self.boxOffice?.boxOfficeResult.dailyBoxOfficeList[safe: indexPath.item]?.movieKoreanName
            let viewController = MovieInfoViewController(movieCode: movieCode, movieName: movieName, coder: creator)
            
            return viewController
        }) {
            self.navigationController?.pushViewController(movieInfoVC, animated: true)
        }
    }
}

extension BoxOfficeViewController: DateDelegate {
    func sendDate(date: Date) {
        self.selectedDate = date
    }
}
