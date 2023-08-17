//
//  BoxOfficeViewController.swift
//  BoxOffice
//
//  Created by kyungmin, Erick on 2023/07/24.
//

import UIKit

final class BoxOfficeViewController: UIViewController {
    private let boxOfficeManager: BoxOfficeManager
    private var collectionViewMode: CollectionViewMode
    private var collectionView: UICollectionView!
    private var dailyBoxOfficeDataSource: UICollectionViewDiffableDataSource<Section, DailyBoxOffice>!
    private let activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        return activityIndicator
    }()
    
    init(boxOfficeManager: BoxOfficeManager, collectionViewMode: CollectionViewMode) {
        self.boxOfficeManager = boxOfficeManager
        self.collectionViewMode = collectionViewMode

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupComponents()
        setupDataSource()
        loadBoxOfficeData()
        configureUI()
        setupConstraint()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupNavigation()
    }
}

// MARK: setup Components
extension BoxOfficeViewController {
    private func setupComponents() {
        setupView()
        setupNavigation()
        setupToolbar()
        setupCollectionView()
        setupRefreshControl()
    }
    
    private func setupView() {
        view.backgroundColor = .systemBackground
    }
    
    private func setupNavigation() {
        let selectDateButton = UIBarButtonItem(title: NameSpace.peakDate, style: .plain, target: self, action: #selector(didTapSelectDateButton))
        
        navigationItem.title = DateFormatter().dateString(from: boxOfficeManager.targetDate, with: DateFormatter.FormatCase.hyphen)
        navigationItem.rightBarButtonItem = selectDateButton
        navigationController?.setToolbarHidden(false, animated: false)
    }
    
    private func setupToolbar() {
        let changeViewModeButton = UIBarButtonItem(title: NameSpace.changeMode, style: .plain, target: self, action: #selector(didTapChangeViewModeButton))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        
        toolbarItems = [flexibleSpace, changeViewModeButton, flexibleSpace]
    }
    
    private func setupCollectionView() {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: listLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(BoxOfficeCollectionViewListCell.self, forCellWithReuseIdentifier: BoxOfficeCollectionViewListCell.identifier)
        collectionView.register(BoxOfficeCollectionViewGridCell.self, forCellWithReuseIdentifier: BoxOfficeCollectionViewGridCell.identifier)
        collectionView.delegate = self
    }
    
    private func setupCollectionViewLayout() {
        switch collectionViewMode {
        case .list:
            collectionView.setCollectionViewLayout(listLayout(), animated: true)
        case .grid:
            collectionView.setCollectionViewLayout(gridLayout(), animated: true)
        }
    }
    
    private func setupRefreshControl() {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(fetchBoxOfficeData), for: .valueChanged)
        
        collectionView.refreshControl = refreshControl
    }
}

// MARK: Data Load
extension BoxOfficeViewController {
    private func loadBoxOfficeData() {
        activityIndicator.startAnimating()
        fetchBoxOfficeData()
    }
    
    @objc private func fetchBoxOfficeData() {
        boxOfficeManager.fetchBoxOffice { result in
            if result == false {
                DispatchQueue.main.async {
                    let alertAction = UIAlertAction(title: NameSpace.check, style: .default)
                    let alert = UIAlertController.customAlert(alertTile: NameSpace.fail, alertMessage: NameSpace.loadDataFail, preferredStyle: .alert, alertActions: [alertAction])
                    
                    self.collectionView.refreshControl?.endRefreshing()
                    self.activityIndicator.stopAnimating()
                    self.present(alert, animated: false)
                }
                
                return
            }
            
            DispatchQueue.main.async {
                self.applySnapshot()
                self.collectionView.refreshControl?.endRefreshing()
                self.activityIndicator.stopAnimating()
            }
        }
    }
}

// MARK: Button Action
extension BoxOfficeViewController {
    @objc private func didTapSelectDateButton() {
        if #available(iOS 16.0, *) {
            let dateComponents = Calendar.current.dateComponents([.year, .month, .day], from: boxOfficeManager.targetDate)
            let calendarViewController = CalendarViewController(selectedDate: dateComponents)
            calendarViewController.delegate = self
            
            present(calendarViewController, animated: true)
        } else {
            return
        }
    }
    
    @objc private func didTapChangeViewModeButton() {
        let action: UIAlertAction = {
            switch collectionViewMode {
            case .list:
                return  UIAlertAction(title: NameSpace.icon, style: .default) { [weak self] _ in
                    guard let self else {
                        return
                    }
                    
                    self.collectionViewMode = .grid
                    self.setupCollectionViewLayout()
                    self.applyReloadSnapshot()
                }
            case .grid:
                return UIAlertAction(title: NameSpace.list, style: .default) { [weak self] _ in
                    guard let self else {
                        return
                    }
                    
                    self.collectionViewMode = .list
                    self.setupCollectionViewLayout()
                    self.applyReloadSnapshot()
                }
            }
        }()
        
        let cancelAction = UIAlertAction(title: NameSpace.cancel, style: .cancel)
        let changeModeAlert = UIAlertController.customAlert(alertTile: NameSpace.selectMode, alertMessage: nil, preferredStyle: .actionSheet, alertActions: [action, cancelAction])
        
        present(changeModeAlert, animated: true)
    }
}

// MARK: CollectionView Layout
extension BoxOfficeViewController {
    private func listLayout() -> UICollectionViewCompositionalLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(80))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(80))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        
        return UICollectionViewCompositionalLayout(section: section)
    }
    
    private func gridLayout() -> UICollectionViewCompositionalLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalWidth(0.5))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 8)
        let section = NSCollectionLayoutSection(group: group)
        
        return UICollectionViewCompositionalLayout(section: section)
    }
}

// MARK: CollectionView DataSource
extension BoxOfficeViewController {
    private func setupDataSource() {
        dailyBoxOfficeDataSource = UICollectionViewDiffableDataSource<Section, DailyBoxOffice>(collectionView: collectionView) { collectionView, indexPath, dailyBoxOffice in
            switch self.collectionViewMode {
            case .list:
                guard let listCell = collectionView.dequeueReusableCell(withReuseIdentifier: BoxOfficeCollectionViewListCell.identifier, for: indexPath) as? BoxOfficeCollectionViewListCell else {
                    return UICollectionViewCell()
                }
                
                listCell.setupLabels(dailyBoxOffice)
                
                return listCell
            case .grid:
                guard let gridCell = collectionView.dequeueReusableCell(withReuseIdentifier: BoxOfficeCollectionViewGridCell.identifier, for: indexPath) as? BoxOfficeCollectionViewGridCell else {
                    return UICollectionViewCell()
                }
                
                gridCell.setupLabels(dailyBoxOffice)
                
                return gridCell
            }
        }
    }
}

// MARK: CollectionView Delegate
extension BoxOfficeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movieCode = boxOfficeManager.dailyBoxOffices[indexPath.item].movieCode
        let movieName = boxOfficeManager.dailyBoxOffices[indexPath.item].movieTitle
        let movieDetailViewController = MovieDetailViewController(boxOfficeManager: boxOfficeManager, movieName: movieName ,movieCode: movieCode)
        
        navigationController?.pushViewController(movieDetailViewController, animated: true)
    }
}

// MARK: CollectionView Snapshot
extension BoxOfficeViewController {
    private func applySnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, DailyBoxOffice>()
        snapshot.appendSections([.main])
        snapshot.appendItems(boxOfficeManager.dailyBoxOffices, toSection: .main)
        
        dailyBoxOfficeDataSource.apply(snapshot, animatingDifferences: true)
    }
    
    private func applyReloadSnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, DailyBoxOffice>()
        snapshot.appendSections([.main])
        snapshot.appendItems(boxOfficeManager.dailyBoxOffices, toSection: .main)
        snapshot.reloadSections([.main])
        
        dailyBoxOfficeDataSource.apply(snapshot, animatingDifferences: true)
    }
}

// MARK: CalendarViewControllerDelegate
extension BoxOfficeViewController: CalendarViewControllerDelegate {
    func calendarViewController(_ calendarViewController: UIViewController, didSelectDate dateComponents: DateComponents?) {
        guard let dateComponents = dateComponents,
              let selectedDate = dateComponents.date else {
            return
        }
        
        boxOfficeManager.setTargetDate(selectedDate)
        activityIndicator.startAnimating()
        loadBoxOfficeData()
        setupNavigation()
    }
}

// MARK: configure UI
extension BoxOfficeViewController {
    private func configureUI() {
        configureView()
    }
    
    private func configureView() {
        view.addSubview(collectionView)
        view.addSubview(activityIndicator)
    }
}

// MARK: setup Constraint
extension BoxOfficeViewController {
    private func setupConstraint() {
        setupCollectionVeiwConstraint()
        setupActivityIndicatorConstraint()
    }
    
    private func setupCollectionVeiwConstraint() {
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func setupActivityIndicatorConstraint() {
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}

// MARK: Name Space
extension BoxOfficeViewController {
    private enum NameSpace {
        static let peakDate = "날짜선택"
        static let fail = "실패"
        static let loadDataFail = "데이터 로드에 실패했습니다."
        static let check = "확인"
        static let changeMode = "화면 모드 변경"
        static let icon = "아이콘"
        static let list = "리스트"
        static let cancel = "취소"
        static let selectMode = "화면모드선택"
    }
}

// MARK: CollectionView Section
extension BoxOfficeViewController {
    private enum Section {
        case main
    }
}

// MARK: CollectionView Mode
extension BoxOfficeViewController {
    enum CollectionViewMode {
        case list
        case grid
    }
}
