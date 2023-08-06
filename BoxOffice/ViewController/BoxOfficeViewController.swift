//
//  BoxOfficeViewController.swift
//  BoxOffice
//
//  Created by kjs on 13/01/23.
//

import UIKit

final class BoxOfficeViewController: UIViewController {
    private let activityIndicatorView = UIActivityIndicatorView(style: .medium)
    
    private let boxOfficeService: BoxOfficeService
    private var boxOffice: BoxOffice?
    private var movie: Movie?
    
    private var dataSource: UICollectionViewDiffableDataSource<Section, DailyBoxOffice>? = nil
    private var collectionView: UICollectionView? = nil
    private let refresher = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showLoadingView()
        setTitle()
        configureBackgroundColor()
        loadDailyBoxOfficeData()
    }
    
    init(boxOfficeService: BoxOfficeService) {
        self.boxOfficeService = boxOfficeService
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI Configuration
    private func showLoadingView() {
        view.addSubview(activityIndicatorView)
        
        activityIndicatorView.center = view.center
        activityIndicatorView.startAnimating()
    }
    
    private func hideLoadingView() {
        activityIndicatorView.stopAnimating()
        activityIndicatorView.removeFromSuperview()
    }
    
    private func setTitle() {
        self.title = boxOfficeService.formattedYesterdayWithHyphen
    }
    
    private func configureBackgroundColor() {
        view.backgroundColor = .systemBackground
    }
    
    // MARK: - Load Data
    @objc private func loadDailyBoxOfficeData() {
        boxOfficeService.loadDailyBoxOfficeData(fetchBoxOffice)
    }
    
    private func fetchBoxOffice(_ result: Result<BoxOffice, NetworkManagerError>) {
        switch result {
        case .success(let boxOffice):
            self.boxOffice = boxOffice
            
            if self.collectionView == nil {
                DispatchQueue.main.async {
                    self.configureHierarchy()
                    self.configureDataSource()
                    self.hideLoadingView()
                }
            } else {
                var snapshot = NSDiffableDataSourceSnapshot<Section, DailyBoxOffice>()
                snapshot.appendSections([.dailyBoxOffice])
                snapshot.appendItems(boxOffice.boxOfficeResult.dailyBoxOfficeList)
                dataSource?.apply(snapshot, animatingDifferences: false)
                
                DispatchQueue.main.async {
                    self.refresher.endRefreshing()
                }
            }
            
            if let movieCode = boxOffice.boxOfficeResult.dailyBoxOfficeList.first?.movieCode {
                boxOfficeService.loadMovieDetailData(movieCd: movieCode, fetchMovie)
            }
        case .failure(let error):
            DispatchQueue.main.async {
                self.showAlert("박스오피스", error)
            }
        }
    }
    
    private func fetchMovie(_ result: Result<Movie, NetworkManagerError>) {
        switch result {
        case .success(let movie):
            self.movie = movie
        case .failure(let error):
            DispatchQueue.main.async {
                self.showAlert("영화 상세 정보", error)
            }
        }
    }
}

// MARK: - Configure CollectionView UI
extension BoxOfficeViewController {
    private func createLayout() -> UICollectionViewLayout {
        let config = UICollectionLayoutListConfiguration(appearance: .plain)
        let layout = UICollectionViewCompositionalLayout.list(using: config)
        
        return layout
        
    }
    
    private func configureHierarchy() {
        collectionView = UICollectionView(frame: view.safeAreaLayoutGuide.layoutFrame, collectionViewLayout: createLayout())
        collectionView?.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView?.delegate = self
        collectionView?.refreshControl = refresher
        collectionView?.refreshControl?.addTarget(self, action: #selector(loadDailyBoxOfficeData), for: .valueChanged)
        collectionView?.refreshControl?.transform = CGAffineTransformMakeScale(0.6, 0.6);
        
        view.addSubview(collectionView ?? UICollectionView())
    }
    
    private func configureDataSource() {
        guard let collectionView else { return }
        
        let cellRegistration = UICollectionView.CellRegistration<BoxOfficeCell, DailyBoxOffice> { (cell, indexPath, dailyBoxOffice) in
            cell.rankLabel.text = dailyBoxOffice.rank
            cell.rankInformationLabel.attributedText = self.changeRankInformation(in: dailyBoxOffice)
            cell.detailLabel.text = self.makeDetailLabelText(in: dailyBoxOffice)
            cell.accessories = [.disclosureIndicator()]
        }
        
        dataSource = UICollectionViewDiffableDataSource<Section, DailyBoxOffice>(collectionView: collectionView) { collectionView, indexPath, itemIdentifier in
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
        }
        
        var snapshot = NSDiffableDataSourceSnapshot<Section, DailyBoxOffice>()
        snapshot.appendSections([.dailyBoxOffice])
        snapshot.appendItems(boxOffice?.boxOfficeResult.dailyBoxOfficeList ?? [])
        dataSource?.apply(snapshot, animatingDifferences: false)
    }
}

// MARK: - CollectionView Delegate
extension BoxOfficeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}

// MARK: - Functions
extension BoxOfficeViewController {
    private func changeRankInformation(in dailyBoxOffice: DailyBoxOffice) -> NSMutableAttributedString {
        if dailyBoxOffice.rankOldAndNew == "NEW" {
            return "신작".addAttributeFontForKeyword(keyword: "신작", color: .red)
        } else if dailyBoxOffice.rankIntensification == "0" {
            return "-".addAttributeFontForKeyword(keyword: "-", color: .black)
        } else if dailyBoxOffice.rankIntensification.contains("-") {
            let rankIntensification = dailyBoxOffice.rankIntensification.replacingOccurrences(of: "-", with: "▼")
            
            return rankIntensification.addAttributeFontForKeyword(keyword: "▼", color: .blue)
        } else {
            let rankIntensification = "▲\(dailyBoxOffice.rankIntensification)"
            
            return rankIntensification.addAttributeFontForKeyword(keyword: "▲", color: .red)
        }
    }
    
    private func makeDetailLabelText(in dailyBoxOffice: DailyBoxOffice) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        
        let audienceCount = formatter.string(for: Int(dailyBoxOffice.audienceCount)) ?? "0"
        let audienceAccumulation = formatter.string(for: Int(dailyBoxOffice.audienceAccumulation)) ?? "0"
        
        return "\(dailyBoxOffice.movieName)\n오늘: \(audienceCount) / 총: \(audienceAccumulation)"
    }
    
    private func showAlert(_ message: String, _ error: NetworkManagerError) {
        let alert = UIAlertController(title: "Error 발생", message: "\(message) 로드에 실패하였습니다.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("확인", comment: "close"), style: .default, handler: { _ in
            NSLog(error.localizedDescription)
        }))
        self.present(alert, animated: true, completion: nil)
    }
}
