//
//  BoxOfficeViewController.swift
//  BoxOffice
//
//  Created by kjs on 13/01/23.
//

import UIKit

final class BoxOfficeViewController: UIViewController, UICollectionViewDelegate {
    // MARK: Properties
    private var rankingViewType: BoxOfficeRankingViewType = .list
    private var dataManager: DataManager?

    // MARK: UI Properties
    private let loadingView = UIActivityIndicatorView()
    private let refreshController = UIRefreshControl()
    private var collectionView: UICollectionView?

    // MARK: DataSource Properties
    private var dataSource: UICollectionViewDiffableDataSource<BoxOfficeRankingViewType, BoxOfficeMovieInfo>?

    override func viewDidLoad() {
        super.viewDidLoad()
        createDataManager()
        fetchBoxOfficeData()
        startLoadingView()
        configureUI()
    }

    private func createDataManager() {
        guard let boxOfficeDate = Date.yesterday else {
            dataManager = DataManager(date: Date())
            return
        }
        dataManager = DataManager(date: boxOfficeDate)
    }

    private func fetchBoxOfficeData() {
        dataManager?.fetchRanking(handler: boxOfficeFetchDataResult)
    }

    private func boxOfficeFetchDataResult(result: Result<[BoxOfficeMovieInfo], Error>) {
        switch result {
        case .success(_):
            DispatchQueue.main.async {
                self.stopLoadingView()
                self.collectionView?.refreshControl?.endRefreshing()
                self.applySnapshot(section: self.rankingViewType)
            }
        case .failure(let error):
            presentErrorAlert(error: error, title: "\(BoxOfficeError.failedToGetData)")
        }
    }

    private func startLoadingView() {
        self.loadingView.startAnimating()
    }

    private func stopLoadingView() {
        self.loadingView.stopAnimating()
    }

    @objc private func refreshCollectionView() {
        self.fetchBoxOfficeData()
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}

// MARK: UI
private extension BoxOfficeViewController {
    func configureUI() {
        view.backgroundColor = .systemBackground

        let layout = makeCollectionViewListLayout()
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)

        configureNavigationTitle()
        configureCollectionViewLayout()
        configureLoadingView()
        configureRefreshController()
    }

    func configureNavigationTitle() {
        navigationItem.title = dataManager?.navigationTitleText
    }

    func makeCollectionViewListLayout() -> UICollectionViewCompositionalLayout {
        let configuration = UICollectionLayoutListConfiguration(appearance: .plain)
        let layout = UICollectionViewCompositionalLayout.list(using: configuration)

        return layout
    }

    func configureCollectionViewLayout() {
        guard let collectionView = collectionView else { return }

        view.addSubview(collectionView)

        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self

        addConstraintCollectionView(collectionView)
        createDataSource(collectionView)
    }

    func addConstraintCollectionView(_ collectionView: UICollectionView) {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    func configureLoadingView() {
        loadingView.center = view.center
        loadingView.style = .large

        view.addSubview(loadingView)
    }

    func configureRefreshController() {
        refreshController.addTarget(self, action: #selector(refreshCollectionView), for: .valueChanged)
        collectionView?.refreshControl = refreshController
    }

    func createDataSource(_ collectionView: UICollectionView) {
        let listCellRegistration = makeListCellRegistration()

        dataSource = UICollectionViewDiffableDataSource<BoxOfficeRankingViewType, BoxOfficeMovieInfo>(
            collectionView: collectionView,
            cellProvider: { collectionView, indexPath, itemIdentifier in
                return collectionView.dequeueConfiguredReusableCell(
                    using: listCellRegistration,
                    for: indexPath,
                    item: itemIdentifier
                )
            }
        )
    }

    func makeListCellRegistration() -> UICollectionView.CellRegistration<MovieRankingListCell, BoxOfficeMovieInfo> {
        return UICollectionView.CellRegistration<MovieRankingListCell, BoxOfficeMovieInfo> { cell, indexPath, item in
            let uiModel = CellUIModel(data: item)
            cell.updateCellData(for: uiModel)
        }
    }

    func applySnapshot(section: BoxOfficeRankingViewType?) {
        guard let dataManager = dataManager,
              let section = section else { return }

        var snapshot = NSDiffableDataSourceSnapshot<BoxOfficeRankingViewType, BoxOfficeMovieInfo>()

        snapshot.appendSections([section])
        snapshot.appendItems(dataManager.movieItems)

        dataSource?.apply(snapshot, animatingDifferences: true)
    }
}
