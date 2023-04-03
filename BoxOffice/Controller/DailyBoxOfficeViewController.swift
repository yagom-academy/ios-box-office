//
//  DailyBoxOfficeViewController.swift
//  BoxOffice
//
//  Created by 리지, kokkilE on 2023/03/27.
//

import UIKit

protocol DateUpdatable {
    var selectedDate: Date { get set }
    
    func refreshData()
}

@available(iOS 16.0, *)
final class DailyBoxOfficeViewController: UIViewController, DateUpdatable {
    var selectedDate: Date = Date(timeIntervalSinceNow: -86400)
    
    private typealias DataSource = UICollectionViewDiffableDataSource<Section, DailyBoxOfficeItem>
    
    private let networkManager = NetworkManager()
    private var boxOfficeEndPoint: BoxOfficeEndPoint?
    private var movieDataSource: DataSource?
    private var dailyBoxOfficeItem: [DailyBoxOfficeItem] = []
    
    private let dateFormatter = DateFormatter()
    private let refreshControl = UIRefreshControl()
    
    private let selectDateButton = UIBarButtonItem()
    
    lazy private var collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createMovieListLayout())
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(collectionView)
    
        configureCollectionView()
        configureSelectionDateButton()
        refreshData()
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
    }
    
    @objc func refreshData() {
        updateDateToViewTitle()
        updateDateToEndPoint()
        fetchDailyBoxOfficeData()
    }
    
    private func configureCollectionView() {
        collectionView.delegate = self
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.register(DailyBoxOfficeCollectionViewCell.self, forCellWithReuseIdentifier: DailyBoxOfficeCollectionViewCell.reuseIdentifier)
        collectionView.refreshControl = refreshControl
    }
    
    private func configureSelectionDateButton() {
        navigationItem.rightBarButtonItem = selectDateButton
        selectDateButton.title = "날짜선택"
        selectDateButton.style = .plain
        selectDateButton.target = self
        selectDateButton.action = #selector(selectDateButtonTapped)
    }

    @objc private func selectDateButtonTapped() {
        let nextViewController = SelectDateViewController()
        nextViewController.delegate = self
        navigationController?.present(nextViewController, animated: true)
    }
    
    private func updateDateToViewTitle() {
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let currentDate = dateFormatter.string(from: selectedDate)
        
        self.title = currentDate
    }
    
    private func updateDateToEndPoint() {
        dateFormatter.dateFormat = "yyyyMMdd"
        let currentDate = dateFormatter.string(from: selectedDate)
        
        boxOfficeEndPoint = BoxOfficeEndPoint.DailyBoxOffice(tagetDate: "\(currentDate)")
    }
    
    private func fetchDailyBoxOfficeData() {
        guard let endPoint = boxOfficeEndPoint else { return }
        
        networkManager.request(endPoint: endPoint, returnType: DailyBoxOffice.self) { [weak self] in
            switch $0 {
            case .failure(let error):
                print(error)
            case .success(let result):
                self?.applyMoviesToDailyBoxOfficeItem(from: result.boxOfficeResult.boxOfficeList)
                
                DispatchQueue.main.async {
                    self?.setupDataSource()
                    self?.applySnapshotToDataSource()
                    self?.refreshControl.endRefreshing()
                }
            }
        }
    }
    
    private func applyMoviesToDailyBoxOfficeItem(from movies: [DailyBoxOffice.BoxOfficeResult.Movie]) {
        dailyBoxOfficeItem = movies.map {
            DailyBoxOfficeItem(from: $0)
        }
    }
}

@available(iOS 16.0, *)
extension DailyBoxOfficeViewController {
    private func setupDataSource() {
        movieDataSource = DataSource(collectionView: collectionView) { collectionView, indexPath, itemIdentifier in
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: DailyBoxOfficeCollectionViewCell.reuseIdentifier,
                for: indexPath) as? DailyBoxOfficeCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.configure(with: itemIdentifier)
            
            return cell
        }
    }
    
    private func applySnapshotToDataSource() {
        typealias Snapshot = NSDiffableDataSourceSnapshot<Section, DailyBoxOfficeItem>
        var snapshot = Snapshot()
        snapshot.appendSections([.main])
        snapshot.appendItems(dailyBoxOfficeItem, toSection: .main)
        
        movieDataSource?.apply(snapshot, animatingDifferences: true)
    }
}

@available(iOS 16.0, *)
extension DailyBoxOfficeViewController {
    private func createMovieListLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .estimated(44))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .estimated(44))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        return layout
    }
}

@available(iOS 16.0, *)
extension DailyBoxOfficeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movieName = dailyBoxOfficeItem[indexPath.item].name
        let movieCode = dailyBoxOfficeItem[indexPath.item].code
        
        let nextViewcontroller = MovieInformationViewController(movieName: movieName, movieCode: movieCode)
        navigationController?.pushViewController(nextViewcontroller, animated: true)
    }
}

enum Section: Hashable {
    case main
}

struct DailyBoxOfficeItem: Hashable {
    let identifier = UUID()
    let rank: String
    let rankVariance: String
    let rankOldAndNew: String
    let code: String
    let name: String
    let audienceCount: String
    let audienceAccumulation: String
    
    init(from movie: DailyBoxOffice.BoxOfficeResult.Movie) {
        self.rank = movie.rank
        self.rankVariance = movie.rankVariance
        self.rankOldAndNew = movie.rankOldAndNew
        self.code = movie.code
        self.name = movie.name
        self.audienceCount = movie.audienceCount
        self.audienceAccumulation = movie.audienceAccumulation
    }
}
