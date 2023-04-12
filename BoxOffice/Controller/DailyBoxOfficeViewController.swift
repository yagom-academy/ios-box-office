//
//  DailyBoxOfficeViewController.swift
//  BoxOffice
//
//  Created by 리지, kokkilE on 2023/03/27.
//

import UIKit

protocol DateUpdatable: AnyObject {
    var selectedDate: Date { get set }
    
    func refreshData()
}

final class DailyBoxOfficeViewController: UIViewController, DateUpdatable {
    private typealias DataSource = UICollectionViewDiffableDataSource<Section, DailyBoxOfficeItem>
    private typealias Snapshot = NSDiffableDataSourceSnapshot<Section, DailyBoxOfficeItem>
    
    private let networkManager = NetworkManager()
    private var boxOfficeEndPoint: BoxOfficeEndPoint?
    private var movieDataSource: DataSource?
    private var dailyBoxOfficeItem: [DailyBoxOfficeItem] = []
    private var screenMode = ScreenMode.list
    
    private let refreshControl = UIRefreshControl()
    private let dateFormatter = DateFormatter()
    var selectedDate: Date = Date(timeIntervalSinceNow: -86400)
    
    lazy private var collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createMovieListLayout())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(collectionView)
        DailyBoxOfficeCoreDataManager.shared.deleteByTimeInterval()
        MovieInformationCoreDataManager.shared.deleteByTimeInterval()

        configureCollectionView()
        configureSelectionDateButton()
        configureToolBar()
        refreshData()
    }
    
    @objc func refreshData() {
        updateDateToViewTitle()
        updateDateToEndPoint()
        fetchDailyBoxOfficeData()
    }
    
    private func configureCollectionView() {
        collectionView.delegate = self
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        collectionView.register(DailyBoxOfficeListCollectionViewCell.self, forCellWithReuseIdentifier: DailyBoxOfficeListCollectionViewCell.reuseIdentifier)
        collectionView.register(DailyBoxOfficeIconCollectionViewCell.self, forCellWithReuseIdentifier: DailyBoxOfficeIconCollectionViewCell.reuseIdentifier)
        
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        collectionView.refreshControl = refreshControl
    }
    
    private func configureSelectionDateButton() {
        let selectDateButton = UIBarButtonItem(title: "날짜선택",
                                               style: .plain,
                                               target: self,
                                               action: #selector(selectDateButtonTapped))
        
        navigationItem.rightBarButtonItem = selectDateButton
    }
    
    @objc private func selectDateButtonTapped() {
        let selectDateViewController = SelectDateViewController()
        selectDateViewController.delegate = self
        navigationController?.present(selectDateViewController, animated: true)
    }
    
    private func configureToolBar() {
        self.navigationController?.isToolbarHidden = false
        let changeScreenModeButton = UIBarButtonItem(title: "화면 모드 변경",
                                                     style: .plain,
                                                     target: self,
                                                     action: #selector(changeScreenModeButtonTapped))
        
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace,
                                            target: self,
                                            action: nil)
        var items = [UIBarButtonItem]()
        [flexibleSpace, changeScreenModeButton, flexibleSpace].forEach { items.append($0) }
        
        self.toolbarItems = items
    }
    
    @objc private func changeScreenModeButtonTapped() {
        let title = screenMode.oppositeTitle
        AlertManager.shared.showAlert(target: self,
                                      alertTitle: "화면모드변경",
                                      message: nil,
                                      style: .actionSheet,
                                      okActionTitle: title,
                                      cancelActionTitle: "취소") { [weak self] _ in
            self?.screenMode.changeMode()
            self?.updateCell()
        }
    }
    
    private func updateCell() {
        DispatchQueue.main.async { [weak self] in
            self?.setupDataSource()
            self?.updateDataSource()
            
            switch self?.screenMode {
            case .list:
                guard let movieListLayout = self?.createMovieListLayout() else { return }
                self?.collectionView.collectionViewLayout = movieListLayout
            case .icon:
                guard let movieIconLayout = self?.createMovieIconLayout() else { return }
                self?.collectionView.collectionViewLayout = movieIconLayout
            case .none:
                return
            }
        }
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
        
        dateFormatter.dateFormat = "yyyyMMdd"
        let selectedDate = dateFormatter.string(from: selectedDate)
        
        if let fetchedData = DailyBoxOfficeCoreDataManager.shared.read(key: selectedDate) as? DailyBoxOfficeData,
           let movies = fetchedData.movies {
            applyMoviesToDailyBoxOfficeItem(from: movies.movieList)
            
            DispatchQueue.main.async { [weak self] in
                self?.setupDataSource()
                self?.updateDataSource()
                self?.refreshControl.endRefreshing()
            }
            
            return
        }
        
        networkManager.request(endPoint: endPoint, returnType: DailyBoxOffice.self) { [weak self] in
            switch $0 {
            case .failure(let error):
                print(error)
            case .success(let result):
                
                DailyBoxOfficeCoreDataManager.shared.create(key: selectedDate, value: result.boxOfficeResult.boxOfficeList)
                
                guard let fetchedData = DailyBoxOfficeCoreDataManager.shared.read(key: selectedDate) as? DailyBoxOfficeData,
                      let movies = fetchedData.movies else { return }
                self?.applyMoviesToDailyBoxOfficeItem(from: movies.movieList)
                
                DispatchQueue.main.async {
                    self?.setupDataSource()
                    self?.updateDataSource()
                    self?.refreshControl.endRefreshing()
                }
            }
        }
    }
    
    private func applyMoviesToDailyBoxOfficeItem(from movies: [Movie]) {
        dailyBoxOfficeItem = movies.map {
            DailyBoxOfficeItem(from: $0)
        }
    }
}

extension DailyBoxOfficeViewController {
    private func setupDataSource() {
        movieDataSource = DataSource(collectionView: collectionView) { [weak self] collectionView, indexPath, itemIdentifier in
            
            switch self?.screenMode {
            case .list:
                guard let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: DailyBoxOfficeListCollectionViewCell.reuseIdentifier,
                    for: indexPath) as? DailyBoxOfficeListCollectionViewCell else { return UICollectionViewCell() }
                
                guard let movieInformation = self?.setupCellLabels(with: itemIdentifier) else { return UICollectionViewCell() }
                
                cell.setupLabels(name: movieInformation.name,
                                 audienceInformation: movieInformation.audienceInformation,
                                 rank: movieInformation.rank,
                                 rankMark: movieInformation.rankMark,
                                 audienceVariance: movieInformation.audienceVariance,
                                 rankMarkColor: movieInformation.rankMarkColor)
                
                return cell
            case .icon:
                guard let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: DailyBoxOfficeIconCollectionViewCell.reuseIdentifier,
                    for: indexPath) as? DailyBoxOfficeIconCollectionViewCell else { return UICollectionViewCell() }
                
                guard let movieInformation = self?.setupCellLabels(with: itemIdentifier) else { return UICollectionViewCell() }
                
                cell.setupLabels(name: movieInformation.name,
                                 audienceInformation: movieInformation.audienceInformation,
                                 rank: movieInformation.rank,
                                 rankMark: movieInformation.rankMark,
                                 audienceVariance: movieInformation.audienceVariance,
                                 rankMarkColor: movieInformation.rankMarkColor)
                
                return cell
            case .none:
                return UICollectionViewCell()
            }
        }
    }
    
    private func updateDataSource() {
        var snapshot = Snapshot()
        snapshot.appendSections([.main])
        snapshot.appendItems(dailyBoxOfficeItem, toSection: .main)
        
        movieDataSource?.apply(snapshot, animatingDifferences: true)
    }
    
    private func setupCellLabels(with movie: DailyBoxOfficeItem) -> (name: String, audienceInformation: String, rank: String, rankMark: String, audienceVariance: String, rankMarkColor: MovieRankMarkColor)? {
        var name: String
        var audienceInformation: String
        var rank: String
        var rankMark: String
        var audienceVariance: String
        var rankMarkColor : MovieRankMarkColor
        
        guard let todayAudience = NumberFormatterManager.shared.convertToFormattedNumber(from: movie.audienceCount, style: .decimal),
              let totalAudience = NumberFormatterManager.shared.convertToFormattedNumber(from: movie.audienceAccumulation, style: .decimal) else { return nil }
        
        name = movie.name
        audienceInformation = "오늘 \(todayAudience) / 총 \(totalAudience)"
        rank = movie.rank
        
        if movie.rankOldAndNew == "NEW" {
            rankMarkColor = .red
            rankMark = "신작"
            audienceVariance = ""
        } else {
            guard let variance = Int(movie.rankVariance) else { return nil }
            
            switch variance {
            case ..<0:
                rankMarkColor = .blue
                rankMark = "▼"
                audienceVariance =  "\(variance * -1)"
            case 0:
                rankMarkColor = .black
                rankMark = ""
                audienceVariance = "-"
            default:
                rankMarkColor = .red
                rankMark = "▲"
                audienceVariance = "\(variance)"
            }
        }
        
        return (name: name, audienceInformation: audienceInformation, rank: rank, rankMark: rankMark, audienceVariance: audienceVariance, rankMarkColor: rankMarkColor)
    }
}

extension DailyBoxOfficeViewController {
    private func createMovieIconLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5),
                                              heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 7, leading: 7, bottom: 7, trailing: 7)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .fractionalWidth(0.5))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, repeatingSubitem: item, count: 2)
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 7, leading: 7, bottom: 0, trailing: 7)
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        return layout
    }
    
    private func createMovieListLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .estimated(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .estimated(1))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        return layout
    }
}

extension DailyBoxOfficeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movieName = dailyBoxOfficeItem[indexPath.item].name
        let movieCode = dailyBoxOfficeItem[indexPath.item].code
        
        let movieInformationViewController = MovieInformationViewController(movieName: movieName, movieCode: movieCode)
        navigationController?.pushViewController(movieInformationViewController, animated: true)
    }
}

fileprivate enum ScreenMode {
    case list
    case icon
    
    var oppositeTitle: String {
        switch self {
        case .list:
            return "아이콘"
        case .icon:
            return "리스트"
        }
    }
    
    mutating func changeMode() {
        switch self {
        case .list:
            self = .icon
        case .icon:
            self = .list
        }
    }
}

fileprivate enum Section: Hashable {
    case main
}

struct DailyBoxOfficeItem: Hashable {
    let identifier: UUID
    let rank: String
    let rankVariance: String
    let rankOldAndNew: String
    let code: String
    let name: String
    let audienceCount: String
    let audienceAccumulation: String
    
    init(from movie: Movie) {
        self.identifier = UUID()
        self.rank = movie.rank ?? ""
        self.rankVariance = movie.rankVariance ?? ""
        self.rankOldAndNew = movie.rankOldAndNew ?? ""
        self.code = movie.code ?? ""
        self.name = movie.name ?? ""
        self.audienceCount = movie.audienceCount ?? ""
        self.audienceAccumulation = movie.audienceAccumulation ?? ""
    }
}
