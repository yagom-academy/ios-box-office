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
    
    private let provider = APIProvider.shared
    
    private lazy var currentDate: Date = createYesterdayDate() {
        didSet {
            setTitle(date: currentDate)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
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
    
    private func setTitle(date: Date) {
        createDateString(date: date, option: .title)
            .map { title = $0 }
    }
    
    private func configureCollectionView() {
        let layout = createLayout()
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(collectionView)
        collectionView.delegate = self
    }
    
    private func createLayout() -> UICollectionViewLayout {
        let config = UICollectionLayoutListConfiguration(appearance: .plain)
        return UICollectionViewCompositionalLayout.list(using: config)
    }
    
    private func configureDataSource() {
        let cellRegistration = UICollectionView.CellRegistration<MovieListCell, ListItem> { cell, indexPath, movie in
            
            cell.updateCell(with: movie)
            cell.accessories = [.disclosureIndicator()]
        }
        
        dataSource = UICollectionViewDiffableDataSource<ListSection, ListItem>(collectionView: collectionView) { collectionView, indexPath, movie -> UICollectionViewCell? in
            let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: movie)
            return cell
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
        guard let dateString = createDateString(date: currentDate, option: .api) else { return }
        
        provider.performRequest(api: .boxOffice(date: dateString)) { [weak self] requestResult in
            guard let self else { return }
            
            switch requestResult {
            case .success(let data):
                do {
                    let boxOfficeItem: BoxOfficeItem = try JSONConverter.shared.decodeData(data, T: BoxOfficeItem.self)
                    let dailyBoxOffices = boxOfficeItem.boxOfficeResult.dailyBoxOfficeList
                    var movieRanking: [ListItem] = []
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
    
    private func createYesterdayDate() -> Date {
        let today = Date()
        let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: today) ?? today
        
        return yesterday
    }
    
    private func createDateString(date: Date, option: DateFormatOption) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = option.rawValue
        return dateFormatter.string(from: date)
    }
    
    @objc private func moveToCalendarView() {
        let date: Date = currentDate
        let calendarViewController = CalendarViewController(selectedDate: date)
        calendarViewController.selectionDelegate = self
        present(calendarViewController, animated: true)
    }
    
}

extension ViewController: SelectionDelegate {
    
    func selection(_ date: Date) {
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
