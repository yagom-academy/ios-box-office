//
//  MovieRankingViewController.swift
//  BoxOffice
//
//  Created by Andrew, 레옹아범 on 13/01/23.
//

import UIKit

final class MovieRankingViewController: UIViewController {
    
    // MARK: Propertie
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
    private var dataSource: UICollectionViewDiffableDataSource<APIType, InfoObject>?
    private var snapshot = NSDiffableDataSourceSnapshot<APIType, InfoObject>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        makeDataManager()
        configureUI()
        configureNavigationTitle()
        startLoadingView()
        fetchBoxofficeData()
    }
    
    private func makeDataManager() {
        dataManager = RankingManager(date: boxofficeDate)
    }
    
    private func fetchBoxofficeData() {
        dataManager?.fetchRanking(handler: { [weak self] result in
            switch result {
            case .success(_):
                DispatchQueue.main.async {
                    self?.stopLoadingView()
                    self?.collectionView?.refreshControl?.endRefreshing()
                    self?.applySnapshot()
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
    
    private func configureRefreshController() {
        refreshController.addTarget(self, action: #selector(refreshCollectionView), for: .valueChanged)
        collectionView?.refreshControl = refreshController
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
}

// MARK: CalendarDelegate
extension MovieRankingViewController: CalendarDelegate {
    func changeDate(_ date: Date) {
        startLoadingView()
        boxofficeDate = date
        makeDataManager()
        configureNavigationTitle()
        fetchBoxofficeData()
    }
}

// MARK: Delegate
extension MovieRankingViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let movieItem = dataManager?.movieItems[indexPath.row] else {
            return
        }
        let nextViewController = MovieDetailViewController()
        
        nextViewController.movieName = movieItem.name
        nextViewController.movieCode = movieItem.code
        
        navigationController?.pushViewController(nextViewController, animated: true)
    }
}

// MARK: UI
extension MovieRankingViewController {
    
    private func configureNavigationTitle() {
        guard let navigationTitleText = dataManager?.navigationTitleText else {
            return
        }
        
        navigationItem.title = navigationTitleText
    }
    
    private func configureNavigationItems() {
        configureNavigationTitle()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "날짜 선택", style: .plain, target: self, action: #selector(didTapDateSelectionButton))
    }
    
    private func configureUI() {
        view.backgroundColor = .systemBackground
        
        let layout = makeCollectionViewListLayout()
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        configureCollectionViewLayout()
        configureLoadingView()
        configureNavigationItems()
        configureRefreshController()
        makeDataSource()
    }
    
    private func configureLoadingView() {
        loadingView.center = view.center
        loadingView.style = .large
        
        view.addSubview(loadingView)
    }
    
    private func makeCollectionViewListLayout() -> UICollectionViewCompositionalLayout {
        let configuration = UICollectionLayoutListConfiguration(appearance: .plain)
        let layout = UICollectionViewCompositionalLayout.list(using: configuration)
        
        return layout
    }
    
    private func makeDataSource() {
        guard let collectionView = collectionView else { return }
        
        dataSource = UICollectionViewDiffableDataSource<APIType, InfoObject>(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieRankingCell.identifier, for: indexPath) as? MovieRankingCell else { return UICollectionViewListCell() }
            
            let uiModel = CellUIModel(data: itemIdentifier)
            
            cell.updateLabelText(for: uiModel)
            
            return cell
        })
    }
    
    private func applySnapshot() {
        guard let dataManager = dataManager else { return }
        
        var snapshot = NSDiffableDataSourceSnapshot<APIType, InfoObject>()
    
        snapshot.appendSections([dataManager.apiType])
        snapshot.appendItems(dataManager.movieItems)
        
        dataSource?.apply(snapshot, animatingDifferences: true)
    }

    private func configureCollectionViewLayout() {
        guard let collectionView = collectionView else { return }
        
        view.addSubview(collectionView)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self
        collectionView.register(MovieRankingCell.self, forCellWithReuseIdentifier: MovieRankingCell.identifier)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
