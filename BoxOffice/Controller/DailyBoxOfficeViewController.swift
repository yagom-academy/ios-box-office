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

final class DailyBoxOfficeViewController: UIViewController, DateUpdatable {
    var selectedDate: Date = Date(timeIntervalSinceNow: -86400)
    
    private typealias DataSource = UICollectionViewDiffableDataSource<Section, DailyBoxOfficeItem>
    
    private let networkManager = NetworkManager()
    private var boxOfficeEndPoint: BoxOfficeEndPoint?
    private var movieDataSource: DataSource?
    private var dailyBoxOfficeItem: [DailyBoxOfficeItem] = []
    
    private let dateFormatter = DateFormatter()
    private let refreshControl = UIRefreshControl()
    private var screenMode = ScreenMode.list
    
    lazy private var collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createMovieListLayout())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(collectionView)
    
        configureCollectionView()
        configureSelectionDateButton()
        configureToolBar()
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
        
        switch screenMode {
        case .list:
            collectionView.register(DailyBoxOfficeListCollectionViewCell.self, forCellWithReuseIdentifier: DailyBoxOfficeListCollectionViewCell.reuseIdentifier)
        case .icon:
            collectionView.register(DailyBoxOfficeIconCollectionViewCell.self, forCellWithReuseIdentifier: DailyBoxOfficeIconCollectionViewCell.reuseIdentifier)
        }
       
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
        let nextViewController = SelectDateViewController()
        nextViewController.delegate = self
        navigationController?.present(nextViewController, animated: true)
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
        let alert = UIAlertController(title: "화면모드변경", message: nil, preferredStyle: .actionSheet)
        let title = screenMode.oppositeTitle
        
        let listMode = UIAlertAction(title: title, style: .default) { [self] _ in
            screenMode.changeMode()
            
            switch screenMode {
            case .list:
                collectionView.register(DailyBoxOfficeListCollectionViewCell.self, forCellWithReuseIdentifier: DailyBoxOfficeListCollectionViewCell.reuseIdentifier)
            case .icon:
                collectionView.register(DailyBoxOfficeIconCollectionViewCell.self, forCellWithReuseIdentifier: DailyBoxOfficeIconCollectionViewCell.reuseIdentifier)
            }

            DispatchQueue.main.async { [self] in
                setupDataSource()
                updateDataSource()
                switch screenMode {
                case .list:
                    collectionView.collectionViewLayout = createMovieListLayout()
                case .icon:
                    collectionView.collectionViewLayout = createMovieIconLayout()
                }
            }
        }
        
        let cancelAction = UIAlertAction(title: "취소", style: .cancel)
        alert.addAction(listMode)
        alert.addAction(cancelAction)
        
        present(alert, animated: true)
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
                    self?.updateDataSource()
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
        typealias Snapshot = NSDiffableDataSourceSnapshot<Section, DailyBoxOfficeItem>
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
        
        guard let todayAudience = movie.audienceCount.convertToFormattedNumber(),
              let totalAudience = movie.audienceAccumulation.convertToFormattedNumber() else { return nil }
        
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
        
        let nextViewcontroller = MovieInformationViewController(movieName: movieName, movieCode: movieCode)
        navigationController?.pushViewController(nextViewcontroller, animated: true)
    }
}

fileprivate extension String {
    func convertToFormattedNumber() -> String? {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        
        guard let number = numberFormatter.number(from: self),
              let stringNumber = numberFormatter.string(from: number) else { return nil }
        
        return stringNumber
    }
}
