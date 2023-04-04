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
                applySnapshotToDataSource()
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
        movieDataSource = DataSource(collectionView: collectionView) { [weak self] collectionView, indexPath, itemIdentifier in
            var cellIdentifier: String
           
            switch self?.screenMode {
            case .list:
                cellIdentifier = DailyBoxOfficeListCollectionViewCell.reuseIdentifier
            case .icon:
                cellIdentifier = DailyBoxOfficeIconCollectionViewCell.reuseIdentifier
            case .none:
                return UICollectionViewCell()
            }
            
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: cellIdentifier,
                for: indexPath) as? LabelSetter else { return UICollectionViewCell() }
            
            self?.setupLabels(with: itemIdentifier) { movieListLabel, audienceInformationLabel, movieRankLabel, audienceVarianceLabel in
                cell.configureLabels(movieRankLabel, audienceVarianceLabel, movieListLabel, and: audienceInformationLabel)
            }
         
            return cell as? UICollectionViewCell
        }
    }
    
    private func applySnapshotToDataSource() {
        typealias Snapshot = NSDiffableDataSourceSnapshot<Section, DailyBoxOfficeItem>
        var snapshot = Snapshot()
        snapshot.appendSections([.main])
        snapshot.appendItems(dailyBoxOfficeItem, toSection: .main)
        
        movieDataSource?.apply(snapshot, animatingDifferences: true)
    }
    
    private func setupLabels(with movie: DailyBoxOfficeItem, completion: (UILabel, UILabel, UILabel, UILabel) -> Void) {
        let movieListLabel = UILabel()
        let audienceInformationLabel = UILabel()
        let movieRankLabel = UILabel()
        let audienceVarianceLabel = UILabel()
        
        guard let todayAudience = movie.audienceCount.convertToFormattedNumber(),
              let totalAudience = movie.audienceAccumulation.convertToFormattedNumber() else { return }
        
        movieListLabel.text = movie.name
        movieListLabel.font = UIFont.preferredFont(forTextStyle: .title3)
        movieListLabel.numberOfLines = 0
        
        audienceInformationLabel.text = "오늘 \(todayAudience) / 총 \(totalAudience)"
        audienceInformationLabel.font = UIFont.preferredFont(forTextStyle: .body)
        
        movieRankLabel.text = movie.rank
        movieRankLabel.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        movieRankLabel.textAlignment = .center
        
        if movie.rankOldAndNew == "NEW" {
            audienceVarianceLabel.text = "신작"
            audienceVarianceLabel.textColor = .systemRed
        } else {
            guard let variance = Int(movie.rankVariance) else { return }
            
            switch variance {
            case ..<0:
                let text =  "▼\(variance * -1)"
                let attributedString = NSMutableAttributedString(string: text)
                attributedString.addAttribute(.foregroundColor, value: UIColor.blue, range: (text as NSString).range(of: "▼"))
                audienceVarianceLabel.attributedText = attributedString
            case 0:
                audienceVarianceLabel.text = "-"
            default:
                let text = "▲\(variance)"
                let attributedString = NSMutableAttributedString(string: text)
                attributedString.addAttribute(.foregroundColor, value: UIColor.red, range: (text as NSString).range(of: "▲"))
                audienceVarianceLabel.attributedText = attributedString
            }
        }
        
        audienceVarianceLabel.font = UIFont.preferredFont(forTextStyle: .body)
        audienceVarianceLabel.textAlignment = .center
       
        completion(movieListLabel, audienceInformationLabel, movieRankLabel, audienceVarianceLabel)
    }
}

@available(iOS 16.0, *)
extension DailyBoxOfficeViewController {
    private func createMovieIconLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5),
                                              heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 7, leading: 7, bottom: 7, trailing: 7)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .fractionalWidth(0.5))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 2)

        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 7, leading: 7, bottom: 0, trailing: 7)

        let layout = UICollectionViewCompositionalLayout(section: section)

        return layout
    }
    
    private func createMovieListLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .estimated(100))
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

fileprivate extension String {
    func convertToFormattedNumber() -> String? {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        
        guard let number = numberFormatter.number(from: self),
              let stringNumber = numberFormatter.string(from: number) else { return nil }
        
        return stringNumber
    }
}

enum ScreenMode {
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
