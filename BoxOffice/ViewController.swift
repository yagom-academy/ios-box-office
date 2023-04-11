//
//  ViewController.swift
//  BoxOffice
//
//  Created by Seoyeon Hong on 2023/03/22.
//

import UIKit

final class ViewController: UIViewController {
    
    private var collectionView: UICollectionView!
    private var dataSource: UICollectionViewDiffableDataSource<ListSection, ListItem>!
    private var currentViewOption: ViewOption = .list
    private let provider = APIProvider.shared
    
    private lazy var currentDate: Date = DateManager.createYesterdayDate() {
        didSet {
            setTitle(date: currentDate)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        configureNavigationToolbar()
        configureCollectionView()
        configureDataSource()
        configureRefreshControl()
        fetchBoxOfficeData()
    }
    
    private func configureNavigationBar() {
        setTitle(date: currentDate)
        navigationController?.navigationBar.titleTextAttributes = [.font: UIFont.systemFont(ofSize: 18, weight: .bold)]
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "날짜선택",
            style: .plain,
            target: self,
            action: #selector(moveToCalendarView)
        )
    }
    
    private func configureNavigationToolbar() {
        navigationController?.isToolbarHidden = false
        
        let item = UIBarButtonItem(
            barButtonSystemItem: .flexibleSpace,
            target: self,
            action: nil
        )
        let UIBarButton = UIBarButtonItem(
            title: "화면 모드 변경",
            style: .plain,
            target: self,
            action: #selector(changeViewMode)
        )
        
        setToolbarItems([item, UIBarButton, item], animated: true)
    }
    
    private func setTitle(date: Date) {
        DateManager.formattedDateString(of: date, option: .calendar)
            .map { title = $0 }
    }
    
    private func configureCollectionView() {
        let layout = createListLayout()
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(collectionView)
        collectionView.delegate = self
    }
    
    private func createListLayout() -> UICollectionViewLayout {
        let config = UICollectionLayoutListConfiguration(appearance: .plain)
        return UICollectionViewCompositionalLayout.list(using: config)
    }
    
    private enum iconLayoutConstant {
        static let itemFractionWidth: CGFloat = 0.5
        static let itemabsoluteHeight: CGFloat = 180
        static let itemTop: CGFloat = 0
        static let itemLeading: CGFloat = 10
        static let itemBottom: CGFloat = 0
        static let itemtrailing: CGFloat = 5
        static let groupFractionWidth: CGFloat = 1.0
        static let groupAbsoluteHeight: CGFloat = 180
        static let sectionTop: CGFloat = 0
        static let sectionLeading: CGFloat = 10
        static let sectionBottom: CGFloat = 0
        static let sectiontrailing: CGFloat = 10
        static let sectionSpacing: CGFloat = 10
    }
    
    private func createIconLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(iconLayoutConstant.itemFractionWidth),
            heightDimension: .absolute(iconLayoutConstant.itemabsoluteHeight))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(
            top: iconLayoutConstant.itemTop,
            leading: iconLayoutConstant.itemLeading,
            bottom: iconLayoutConstant.itemBottom,
            trailing: iconLayoutConstant.itemtrailing)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(iconLayoutConstant.groupFractionWidth),
            heightDimension: .estimated(iconLayoutConstant.groupAbsoluteHeight))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                       subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(
            top: iconLayoutConstant.sectionTop,
            leading: iconLayoutConstant.sectionLeading,
            bottom: iconLayoutConstant.sectionBottom,
            trailing: iconLayoutConstant.sectiontrailing)
        section.interGroupSpacing = iconLayoutConstant.sectionSpacing
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
    
    private func configureDataSource() {
        let listCellRegistration = UICollectionView.CellRegistration<MovieListCell, ListItem> { cell, indexPath, movie in
            cell.updateCell(with: movie)
            cell.accessories = [.disclosureIndicator()]
        }
        
        let iconCellRegistration = UICollectionView.CellRegistration<MovieIconCell, ListItem> { cell, indexPath, movie in
            cell.updateCell(with: movie)
        }
        
        dataSource = UICollectionViewDiffableDataSource<ListSection, ListItem>(collectionView: collectionView) { collectionView, indexPath, movie -> UICollectionViewCell? in
            if self.currentViewOption == .list {
                let cell = collectionView.dequeueConfiguredReusableCell(using: listCellRegistration, for: indexPath, item: movie)
                return cell
            } else {
                let cell = collectionView.dequeueConfiguredReusableCell(using: iconCellRegistration, for: indexPath, item: movie)
                return cell
            }
        }
    }
    
    private func configureRefreshControl() {
        let refreshControl = UIRefreshControl()
        
        refreshControl.addTarget(
            self,
            action: #selector(handleRefreshControl),
            for: .valueChanged
        )
        refreshControl.attributedTitle = NSAttributedString(string: "Fetching Movie Data...")
        collectionView.refreshControl = refreshControl
    }
    
    @objc private func handleRefreshControl() {
        fetchBoxOfficeData()
    }
    
    private func fetchBoxOfficeData() {
        guard let dateString = DateManager.formattedDateString(of: currentDate, option: .numerical) else { return }
        
        provider.performRequest(api: .boxOffice(date: dateString)) { [weak self] requestResult in
            guard let self else { return }
            
            switch requestResult {
            case .success(let data):
                do {
                    let boxOfficeItem: BoxOfficeItem = try JSONConverter.shared.decodeData(data, BoxOfficeItem.self)
                    let dailyBoxOffices = boxOfficeItem.boxOfficeResult.dailyBoxOfficeList
                    var movieRanking = [ListItem]()
                    for dailyBoxOffice in dailyBoxOffices {
                        let movieItem = ListItem(
                            rank: dailyBoxOffice.rank,
                            rankIntensity: dailyBoxOffice.rankIntensity,
                            rankOldandNew: dailyBoxOffice.rankOldAndNew.rawValue,
                            movieName: dailyBoxOffice.movieName,
                            audienceCount: dailyBoxOffice.audienceCount,
                            audienceAcc: dailyBoxOffice.audienceAcc,
                            movieCode: dailyBoxOffice.movieCode
                        )
                        movieRanking.append(movieItem)
                    }
                    
                    DispatchQueue.main.async {
                        _ = self.makeSnapshot(with: movieRanking)
                    }
                } catch let error as NetworkError {
                    DEBUG_LOG(error.description)
                } catch {
                    DEBUG_LOG("Unexpected error: \(error)")
                }
                
            case .failure(let error):
                DEBUG_LOG(error)
            }
            DispatchQueue.main.async {
                self.collectionView.refreshControl?.endRefreshing()
            }
        }
    }
    
    private func makeSnapshot(with movies: [ListItem]) -> NSDiffableDataSourceSnapshot<ListSection, ListItem> {
        var snapshot = NSDiffableDataSourceSnapshot<ListSection, ListItem>()
        snapshot.appendSections([.main])
        snapshot.appendItems(movies, toSection: .main)
        dataSource.apply(snapshot, animatingDifferences: false)
        return snapshot
    }
    
    @objc private func moveToCalendarView() {
        let calendarViewController = CalendarViewController(selectedDate: currentDate)
        calendarViewController.selectionDelegate = self
        present(calendarViewController, animated: true)
    }
    
    @objc private func changeViewMode() {
        let alert = UIAlertController(title: "화면모드변경",
                                      message: nil,
                                      preferredStyle: .actionSheet)
        
        let actionTitle: String = currentViewOption == .list ? ViewOption.icon.rawValue : ViewOption.list.rawValue
        let viewModeAction = UIAlertAction(title: actionTitle, style: .default) { [weak self] _ in
            guard let self else { return }
            self.changeView()
        }
        let cancelAction = UIAlertAction(title: "취소", style: .cancel)
        
        alert.addAction(viewModeAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
    
    private func changeView() {
        if currentViewOption == .list {
            collectionView.setCollectionViewLayout(createIconLayout(),
                                                   animated: false)
            collectionView.scrollToItem(at: IndexPath(item: 0, section: 0),
                                        at: .top, animated: false)
            currentViewOption = .icon
        } else if currentViewOption == .icon {
            collectionView.setCollectionViewLayout(createListLayout(),
                                                   animated: false)
            currentViewOption = .list
        }
        
        dataSource.applySnapshotUsingReloadData(dataSource.snapshot())
    }
    
}

extension ViewController: DateSelectionDelegate {
    
    func dateSelection(_ date: Date) {
        currentDate = date
        fetchBoxOfficeData()
    }
    
}

extension ViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let movieCode = dataSource.itemIdentifier(for: indexPath)?.movieCode,
              let movieName = dataSource.itemIdentifier(for: indexPath)?.movieName else {
            collectionView.deselectItem(at: indexPath, animated: true)
            return
        }
        let viewController = DetailMovieInfoViewController(movieCode: movieCode, movieName: movieName)
        navigationController?.pushViewController(viewController, animated: true)
        
        collectionView.deselectItem(at: indexPath, animated: true)
    }
    
}
