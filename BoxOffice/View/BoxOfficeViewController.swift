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
    
    var actionTitle: String {
        switch self {
        case .list:
            return "아이콘"
        case .icon:
            return "리스트"
        }
    }
    
    mutating func toggle() {
        switch self {
        case .list:
            self = .icon
        case .icon:
            self = .list
        }
    }
}

final class BoxOfficeViewController: UIViewController {
    @IBOutlet private weak var collectionView: UICollectionView!
    
    private let boxOfficeDataLoader = BoxOfficeDataLoader()
    private let alertFactory: AlertImplementation = AlertImplementation()
    private var boxOffice: BoxOffice?
    private var selectedDate = Date().previousDate()
    private var layoutMode: LayoutMode = .list
    
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
        let alertData = AlertViewData(title: "화면모드 변경",
                                      message: nil,
                                      style: .actionSheet,
                                      enableOkAction: true,
                                      okActionTitle: layoutMode.actionTitle,
                                      okActionStyle: .default,
                                      enableCancelAction: true,
                                      completion: changeLayout)
        let actionSheet = alertFactory.makeAlert(alertData: alertData)
        
        present(actionSheet, animated: true)
    }
    
    @objc private func refreshData() {
        loadData { [weak self] in
            self?.collectionView.refreshControl?.endRefreshing()
        }
    }
    
    private func configureRefreshControl() {
        self.collectionView.refreshControl = UIRefreshControl()
        self.collectionView.refreshControl?.addTarget(self, action: #selector(refreshData), for: .valueChanged)
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
                    self?.collectionView.reloadData()
                    completion()
                case .failure(let error):
                    self?.showFetchFailAlert(error: error)
                    completion()
                }
            }
        }
    }
    
    private func registerXib() {
        let listCellNib = UINib(nibName: BoxOfficeCollectionViewListCell.identifier, bundle: nil)
        collectionView.register(listCellNib, forCellWithReuseIdentifier: BoxOfficeCollectionViewListCell.identifier)
        
        let iconCellNib = UINib(nibName: BoxOfficeCollectionViewCell.identifier, bundle: nil)
        collectionView.register(iconCellNib, forCellWithReuseIdentifier: BoxOfficeCollectionViewCell.identifier)
    }
    
    private func configureCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        
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
        switch layoutMode {
        case .list:
            collectionView.collectionViewLayout = createListLayout()
        case .icon:
            collectionView.collectionViewLayout = createIconLayout()
        }
    }
    
    private func showFetchFailAlert(error: Error) {
        let alertData = AlertViewData(title: "Error",
                                      message: "데이터 로딩 실패 \n \(error.localizedDescription)",
                                      style: .alert,
                                      enableOkAction: true,
                                      okActionStyle: .default)
        let alert = alertFactory.makeAlert(alertData: alertData)
        
        present(alert, animated: true)
    }
}

extension BoxOfficeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let count = boxOffice?.boxOfficeResult.dailyBoxOfficeList.count else { return 0 }
        
        return count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch layoutMode {
        case .list:
            return configureCell(type: BoxOfficeCollectionViewListCell.self, indexPath: indexPath)
        case .icon:
            return configureCell(type: BoxOfficeCollectionViewCell.self, indexPath: indexPath)
        }
    }
    
    private func configureCell<T: CellConfigurable>(type: T.Type, indexPath: IndexPath) -> UICollectionViewCell {
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

// MARK: - Actionsheet Handler
extension BoxOfficeViewController {
    func changeLayout() {
        layoutMode.toggle()
        configureCollectionViewLayout()
        collectionView.reloadData()
        collectionView.fadeIn()
    }
}
