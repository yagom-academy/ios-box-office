//
//  BoxOfficeViewController.swift
//  BoxOffice
//
//  Created by kaki, harry on 2023/03/20.
//

import UIKit

fileprivate enum LayoutMode {
    case list
    case icon
}

final class BoxOfficeViewController: UIViewController {
    @IBOutlet private weak var listCollectionView: UICollectionView!
    @IBOutlet private weak var iconCollectionView: UICollectionView!
    
    private let boxOfficeDataLoader = BoxOfficeDataLoader()
    private var boxOffice: BoxOffice?
    private var selectedDate = Date().previousDate()
    private var layoutMode: LayoutMode = .list
    private var currenCollectionView: UICollectionView {
        switch layoutMode {
        case .list:
            return listCollectionView
        case .icon:
            return iconCollectionView
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
        loadInitialData()
    }
    
    @objc private func refreshData() {
        loadData { [weak self] in
            self?.currenCollectionView.refreshControl?.endRefreshing()
        }
    }
    
    private func configureRefreshControl() {
        self.listCollectionView.refreshControl = UIRefreshControl()
        self.listCollectionView.refreshControl?.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        self.iconCollectionView.refreshControl = UIRefreshControl()
        self.iconCollectionView.refreshControl?.addTarget(self, action: #selector(refreshData), for: .valueChanged)
    }
    
    private func loadInitialData() {
        activityIndicator.startAnimating()
        
        loadData { [weak self] in
            self?.activityIndicator.stopAnimating()
        }
    }
    
    private func loadData(completion: @escaping () -> ()) {
        boxOfficeDataLoader.loadDailyBoxOffice(date: selectedDate) { result in
            DispatchQueue.main.async { [weak self] in
                switch result {
                case .success(let data):
                    self?.boxOffice = data
                    self?.currenCollectionView.reloadData()
                    completion()
                case .failure(let error):
                    self?.showFailAlert(error: error)
                    completion()
                }
            }
        }
    }
    
    private func registerXib() {
        let listCellNib = UINib(nibName: BoxOfficeCollectionViewListCell.identifier, bundle: nil)
                listCollectionView.register(listCellNib, forCellWithReuseIdentifier: BoxOfficeCollectionViewListCell.identifier)
        
        let iconCellNib = UINib(nibName: BoxOfficeCollectionViewCell.identifier, bundle: nil)
                iconCollectionView.register(iconCellNib, forCellWithReuseIdentifier: BoxOfficeCollectionViewCell.identifier)
    }
    
    private func configureCollectionView() {
        listCollectionView.dataSource = self
        listCollectionView.delegate = self
        iconCollectionView.dataSource = self
        iconCollectionView.delegate = self
        iconCollectionView.isHidden = true
        
        configureRefreshControl()
        configureCollectionViewLayout()
        registerXib()
    }
    
    private func configureInitialView() {
        navigationItem.title = DateFormatter.hyphenText(date: selectedDate)
        self.view.addSubview(activityIndicator)
        configureCollectionView()
    }
    
    private func configureCollectionViewLayout() {
        listCollectionView.collectionViewLayout = createListLayout()
        iconCollectionView.collectionViewLayout = createIconLayout()
    }
    
    @IBAction private func chooseDateButtonTapped(_ sender: UIBarButtonItem) {
        if let calendarVC = storyboard?.instantiateViewController(identifier: CalendarViewController.identifier, creator: {
            [weak self] creator in
            guard let selectedDate = self?.selectedDate else { return UIViewController() }
            
            let viewController = CalendarViewController(date: selectedDate, coder: creator)
            viewController?.delegate = self
            
            return viewController
        }) {
            self.present(calendarVC, animated: true)
        }
    }
    
    @IBAction private func switchLayoutModeTapped() {
        switch layoutMode {
        case .list:
            self.showIconModeSheet { [weak self] _ in
                self?.layoutMode = .icon
                self?.listCollectionView.fadeOut()
                self?.iconCollectionView.fadeIn()
                self?.iconCollectionView.reloadData()
            }
        case .icon:
            self.showListModeSheet { [weak self] _ in
                self?.layoutMode = .list
                self?.iconCollectionView.fadeOut()
                self?.listCollectionView.fadeIn()
                self?.listCollectionView.reloadData()
            }
        }
    }
}

extension BoxOfficeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let count = boxOffice?.boxOfficeResult.dailyBoxOfficeList.count else { return 0 }
        
        return count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.listCollectionView {
            return configureCell(listCollectionView, type: BoxOfficeCollectionViewListCell.self, indexPath: indexPath)
        } else {
            return configureCell(iconCollectionView, type: BoxOfficeCollectionViewCell.self, indexPath: indexPath)
        }
    }
    
    private func configureCell<T: Configurable>(_ collectionView: UICollectionView, type: T.Type, indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: T.identifier,
            for: indexPath) as? T,
              let item = boxOffice?.boxOfficeResult.dailyBoxOfficeList[safe: indexPath.item] as? T.Item else {
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

extension BoxOfficeViewController: UpdateDateDelegate {
    func sendDate(date: Date) {
        selectedDate = date
        navigationItem.title = DateFormatter.hyphenText(date: selectedDate)
        loadInitialData()
    }
}

extension BoxOfficeViewController {
    private func createListLayout() -> UICollectionViewCompositionalLayout {
        var config = UICollectionLayoutListConfiguration(appearance: .plain)
        config.separatorConfiguration.bottomSeparatorInsets = .init(top: 0, leading: 0, bottom: 0, trailing: 0)
        
        return UICollectionViewCompositionalLayout.list(using: config)
    }
    
    private func createIconLayout() -> UICollectionViewCompositionalLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalWidth(0.5))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalWidth(0.5))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, repeatingSubitem: item, count: 2)
        group.interItemSpacing = .fixed(20)
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 15)
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        return layout
    }
}
