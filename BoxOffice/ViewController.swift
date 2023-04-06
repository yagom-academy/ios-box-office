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
    
    private func createIconLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5),
                                              heightDimension: .absolute(180))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 5)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .estimated(180))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10)
        section.interGroupSpacing = 10
        
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
                    let boxOfficeItem: BoxOfficeItem = try JSONConverter.shared.decodeData(data, T: BoxOfficeItem.self)
                    let dailyBoxOffices = boxOfficeItem.boxOfficeResult.dailyBoxOfficeList
                    var movieRanking = [ListItem]()
                    for dailyBoxOffice in dailyBoxOffices {
                        let movieItem = ListItem(
                            rank: dailyBoxOffice.rank,
                            rankInten: dailyBoxOffice.rankInten,
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
        self.present(alert, animated: true, completion: nil)
    }
    
    private func changeView() {
        if case .list = currentViewOption {
            collectionView.setCollectionViewLayout(createIconLayout(),
                                                   animated: true)
            collectionView.scrollToItem(at: IndexPath(item: 0, section: 0),
                                        at: .top, animated: false)
            currentViewOption = .icon
        } else if case .icon = currentViewOption {
            collectionView.setCollectionViewLayout(createListLayout(),
                                                   animated: true)
            currentViewOption = .list
        }
        collectionView.reloadData()
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
