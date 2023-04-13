//
//  MovieRankingViewController.swift
//  BoxOffice
//
//  Created by Andrew, 레옹아범 on 13/01/23.
//

import UIKit

final class MovieRankingViewController: UIViewController {
    // MARK: Propertie
    private var rankingViewType: RankingViewType = .list
    private var dataManager: RankingManager?
    private var boxofficeDate = {
        guard let boxofficeDate = Date.yesterday else {
            return Date()
        }
        return boxofficeDate
    }()
    
    // MARK: UI Properties
    private let loadingView = UIActivityIndicatorView()
    private let refreshController = UIRefreshControl()
    private var collectionView: UICollectionView?
    
    // MARK: DataSource Properties
    private var dataSource: UICollectionViewDiffableDataSource<RankingViewType, InfoObject>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createDataManager()
        configureUI()
        configureNavigationTitle()
        startLoadingView()
        fetchBoxofficeData()
    }
    
    private func createDataManager() {
        dataManager = RankingManager(date: boxofficeDate)
    }
    
    private func fetchBoxofficeData() {
        dataManager?.fetchRanking(handler: { [weak self] result in
            switch result {
            case .success(_):
                DispatchQueue.main.async {
                    self?.stopLoadingView()
                    self?.collectionView?.refreshControl?.endRefreshing()
                    self?.applySnapshot(section: self?.rankingViewType)
                }
            case .failure(let error):
                self?.presentErrorAlert(error: error, title: "박스오피스")
            }
        })
    }

    private func startLoadingView() {
        self.loadingView.startAnimating()
    }
    
    private func stopLoadingView() {
        self.loadingView.stopAnimating()
    }
    
    @objc private func refreshCollectionView() {
        self.fetchBoxofficeData()
    }

    @objc private func didTapDateSelectionButton() {
        let calendarVC = CalendarViewController()
        
        calendarVC.delegate = self
        calendarVC.selectedDate = boxofficeDate
        
        present(calendarVC, animated: true)
    }
    
    @objc private func didTapChangedScreenButton() {
        let alert = UIAlertController(title: "화면모드변경",
                                      message: nil,
                                      preferredStyle: .actionSheet)
        let alertAction = UIAlertAction(title: rankingViewType.anotherTitle, style: .default, handler: { [weak self] _ in
            self?.deleteSnapshot(by: self?.rankingViewType)
            switch self?.rankingViewType {
            case .list:
                guard let iconLayout = self?.makeCollectionViewIconLayout() else { return }
                self?.rankingViewType = .icon
                self?.changeCollectionViewLayout(layout: iconLayout)
            case .icon:
                guard let listLayout = self?.makeCollectionViewListLayout() else { return }
                self?.rankingViewType = .list
                self?.changeCollectionViewLayout(layout: listLayout)
            default:
                return
            }
            self?.applySnapshot(section: self?.rankingViewType)
        })
        let cancelAction = UIAlertAction(title: "취소", style: .cancel)
        
        alert.addAction(alertAction)
        alert.addAction(cancelAction)
        present(alert, animated: true)
    }
}

// MARK: ChangedDateDelegate
extension MovieRankingViewController: ChangedDateDelegate {
    func changeDate(_ date: Date) {
        startLoadingView()
        boxofficeDate = date
        createDataManager()
        configureNavigationTitle()
        fetchBoxofficeData()
    }
}

// MARK: Delegate
extension MovieRankingViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let movieItem = dataManager?.movieItems[indexPath.row] else { return }
        let nextViewController = MovieDetailViewController()
        
        nextViewController.movieName = movieItem.name
        nextViewController.movieCode = movieItem.code
        
        navigationController?.pushViewController(nextViewController, animated: true)
    }
}

// MARK: UI
extension MovieRankingViewController {
    private func configureNavigationTitle() {
        navigationItem.title = dataManager?.navigationTitleText
    }
    
    private func makeCollectionViewListLayout() -> UICollectionViewCompositionalLayout {
        let configuration = UICollectionLayoutListConfiguration(appearance: .plain)
        let layout = UICollectionViewCompositionalLayout.list(using: configuration)
        
        return layout
    }
    
    private func makeCollectionViewIconLayout() -> UICollectionViewCompositionalLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .estimated( view.frame.height / 4))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(view.frame.height / 4))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 10
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        return layout
    }
    
    private func changeCollectionViewLayout(layout: UICollectionViewCompositionalLayout) {
        collectionView?.setCollectionViewLayout(layout, animated: true)
    }
        
    private func applySnapshot(section: RankingViewType?) {
        guard let dataManager = dataManager,
              let section = section else { return }
        
        var snapshot = NSDiffableDataSourceSnapshot<RankingViewType, InfoObject>()
    
        snapshot.appendSections([section])
        snapshot.appendItems(dataManager.movieItems)
        
        dataSource?.apply(snapshot, animatingDifferences: true)
    }
    
    private func deleteSnapshot(by section: RankingViewType?) {
        guard var snapshot = dataSource?.snapshot(),
              let section = section else { return }
        
        snapshot.deleteSections([section])
        
        dataSource?.apply(snapshot)
    }
    
    private func configureUI() {
        view.backgroundColor = .systemBackground
        
        let layout = makeCollectionViewListLayout()
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        configureCollectionViewLayout()
        configureLoadingView()
        configureNavigationItems()
        configureRefreshController()
        createToolbar()
        createDataSource()
    }
    
    private func configureCollectionViewLayout() {
        guard let collectionView = collectionView else { return }
        
        view.addSubview(collectionView)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func configureLoadingView() {
        loadingView.center = view.center
        loadingView.style = .large
        
        view.addSubview(loadingView)
    }
    
    private func configureNavigationItems() {
        configureNavigationTitle()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "날짜 선택", style: .plain, target: self, action: #selector(didTapDateSelectionButton))
    }
    
    private func configureRefreshController() {
        refreshController.addTarget(self, action: #selector(refreshCollectionView), for: .valueChanged)
        collectionView?.refreshControl = refreshController
    }
        
    private func createToolbar() {
        navigationController?.setToolbarHidden(false, animated: true)
        
        let flexibleItem = UIBarButtonItem(systemItem: .flexibleSpace)
        let barButtonItem = UIBarButtonItem(title: "화면 전환", style: .plain, target: self, action: #selector(didTapChangedScreenButton))
        
        setToolbarItems([flexibleItem, barButtonItem, flexibleItem], animated: true)
    }
    
    private func createDataSource() {
        guard let collectionView = self.collectionView else { return }
        
        let listCellRegistration = UICollectionView.CellRegistration<MovieRankingListCell, InfoObject> { cell, indexPath, item in
            
            let uiModel = CellUIModel(data: item)
            
            cell.updateLabelText(for: uiModel)
        }
        
        let iconCellRegistration = UICollectionView.CellRegistration<MovieRankingIconCell, InfoObject> { cell, indexPath, item in
            
            let uiModel = CellUIModel(data: item)
            
            cell.updateLabelText(for: uiModel)
        }
        
        dataSource = UICollectionViewDiffableDataSource<RankingViewType, InfoObject>(collectionView: collectionView, cellProvider: { [self] collectionView, indexPath, itemIdentifier in
            switch self.rankingViewType {
            case .icon:
                return collectionView.dequeueConfiguredReusableCell(using: iconCellRegistration, for: indexPath, item: itemIdentifier)
            case .list:
                return collectionView.dequeueConfiguredReusableCell(using: listCellRegistration, for: indexPath, item: itemIdentifier)
            }
        })
    }
}
