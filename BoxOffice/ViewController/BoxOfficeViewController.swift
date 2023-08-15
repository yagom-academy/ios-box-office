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
    
    private var dataSource: UICollectionViewDiffableDataSource<Section, DailyBoxOffice>? = nil
    private var collectionView: UICollectionView? = nil
    private var viewMode: String?
    private let refresher = UIRefreshControl()
    
    init(boxOfficeService: BoxOfficeService) {
        self.boxOfficeService = boxOfficeService
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let viewMode = UserDefaults.standard.string(forKey: "viewMode") {
            self.viewMode = viewMode
        } else {
            viewMode = "list"
            UserDefaults.standard.set(viewMode, forKey: "viewMode")
        }
        
        setupRightBarButton()
        showLoadingView()
        setupTitle()
        configureBackgroundColor()
        loadDailyBoxOfficeData()
    }
    
    // MARK: - UI Configuration
    private func setupRightBarButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "날짜선택", primaryAction: showCalendarViewController())
    }
    
    private func showLoadingView() {
        view.addSubview(activityIndicatorView)
        navigationController?.isToolbarHidden = false
        
        let modeButton = UIBarButtonItem(title: "화면 모드 변경", primaryAction: showSelector())
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)

        let items = [flexibleSpace, modeButton, flexibleSpace]
        toolbarItems = items
        
        activityIndicatorView.center = view.center
        activityIndicatorView.startAnimating()
    }
    
    private func hideLoadingView() {
        activityIndicatorView.stopAnimating()
        activityIndicatorView.removeFromSuperview()
    }
    
    private func setupTitle() {
        self.title = DateManager.formattedDateWithHyphen
    }
    
    private func configureBackgroundColor() {
        view.backgroundColor = .systemBackground
    }
    
    // MARK: - Load Data
    private func loadDailyBoxOfficeData() {
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
                DispatchQueue.main.async {
                    var snapshot = NSDiffableDataSourceSnapshot<Section, DailyBoxOffice>()
                    snapshot.appendSections([.dailyBoxOffice])
                    snapshot.appendItems(boxOffice.boxOfficeResult.dailyBoxOfficeList)
                    self.dataSource?.apply(snapshot, animatingDifferences: false)
                    
                    self.refresher.endRefreshing()
                }
            }
        case .failure(let error):
            DispatchQueue.main.async {
                AlertManager.showErrorAlert(in: self, "박스오피스", error)
            }
        }
    }
}

// MARK: - Configure CollectionView UI
extension BoxOfficeViewController {
    private func createListLayout() -> UICollectionViewLayout {
        let config = UICollectionLayoutListConfiguration(appearance: .plain)
        let layout = UICollectionViewCompositionalLayout.list(using: config)

        return layout
    }
    
    private func createIconLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5),
                                             heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .fractionalWidth(0.5))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                         subitems: [item])

        let section = NSCollectionLayoutSection(group: group)
        let layout = UICollectionViewCompositionalLayout(section: section)

        return layout
    }
    
    private func configureHierarchy() {
        let collectionViewLayout = viewMode == "list" ? createListLayout : createIconLayout
        collectionView = UICollectionView(frame: view.safeAreaLayoutGuide.layoutFrame, collectionViewLayout: collectionViewLayout())
        collectionView?.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView?.delegate = self
        collectionView?.refreshControl = refresher
        collectionView?.refreshControl?.addAction(refreshData(), for: .valueChanged)
        collectionView?.refreshControl?.transform = CGAffineTransformMakeScale (0.6, 0.6)
        
        view.addSubview(collectionView ?? UICollectionView())
    }
    
    private func configureDataSource() {
        let listCellRegistration = UICollectionView.CellRegistration<BoxOfficeListCell, DailyBoxOffice> { (cell, indexPath, dailyBoxOffice) in
            cell.rankLabel.text = dailyBoxOffice.rank
            cell.rankInformationLabel.attributedText = self.changeRankInformation(in: dailyBoxOffice)
            cell.movieNameLabel.text = dailyBoxOffice.movieName
            cell.audienceCountLabel.text = self.makeDetailLabelText(in: dailyBoxOffice)
            cell.accessories = [.disclosureIndicator()]
        }
        
        let iconCellRegistration = UICollectionView.CellRegistration<BoxOfficeColumnCell, DailyBoxOffice> { (cell, indexPath, dailyBoxOffice) in
            cell.rankLabel.text = dailyBoxOffice.rank
            cell.movieNameLabel.text = dailyBoxOffice.movieName
            cell.rankInformationLabel.attributedText = self.changeRankInformation(in: dailyBoxOffice)
            cell.audienceCountLabel.text = self.makeDetailLabelText(in: dailyBoxOffice)
            cell.layer.borderColor = UIColor.black.cgColor
            cell.layer.borderWidth = 1
        }
        
        guard let collectionView else { return }
        dataSource = UICollectionViewDiffableDataSource<Section, DailyBoxOffice>(collectionView: collectionView) { collectionView, indexPath, itemIdentifier in
            if self.viewMode == "list" {
                return collectionView.dequeueConfiguredReusableCell(using: listCellRegistration, for: indexPath, item: itemIdentifier)
            } else {
                return collectionView.dequeueConfiguredReusableCell(using: iconCellRegistration, for: indexPath, item: itemIdentifier)
            }
        }
        
        dataSource?.apply(setupSnapshot(), animatingDifferences: false)
    }
    
    func setupSnapshot() -> NSDiffableDataSourceSnapshot<Section, DailyBoxOffice> {
        var snapshot = NSDiffableDataSourceSnapshot<Section, DailyBoxOffice>()
        snapshot.appendSections([.dailyBoxOffice])
        snapshot.appendItems(boxOffice?.boxOfficeResult.dailyBoxOfficeList ?? [], toSection: .dailyBoxOffice)
        
        return snapshot
    }
    
    func reloadData() {
        guard var updatedSnapshot = dataSource?.snapshot() else { return }
        updatedSnapshot.reloadSections([.dailyBoxOffice])
        self.dataSource?.apply(updatedSnapshot, animatingDifferences: true)
    }
}

// MARK: - CollectionView Delegate
extension BoxOfficeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        guard let dailyBoxOffice = boxOffice?.boxOfficeResult.dailyBoxOfficeList else { return }
        let movieDetailViewController = MovieDetailViewController(boxOfficeService, dailyBoxOffice[indexPath.row])
        self.navigationController?.pushViewController(movieDetailViewController, animated: true)
    }
}

// MARK: - CalendarViewController Delegate
extension BoxOfficeViewController: CalendarViewControllerDelegate {
    func updateBoxOfficeDate() {
        setupTitle()
        loadDailyBoxOfficeData()
    }
}

// MARK: - Functions
extension BoxOfficeViewController {
    private func showCalendarViewController() -> UIAction {
        let action = UIAction() { _ in
            let calendarViewController = CalendarViewController()
            calendarViewController.delegate = self
            
            self.present(calendarViewController, animated: true)
        }
        
        return action
    }
    
    private func showSelector() -> UIAction {
        let action = UIAction { _ in
            let sheet = UIAlertController(title: "화면모드변경", message: nil, preferredStyle: .actionSheet)
            if self.viewMode == "list" {
                sheet.addAction(UIAlertAction(title: "아이콘", style: .default, handler: { _ in
                    self.viewMode = "icon"
                    UserDefaults.standard.set("icon", forKey: "viewMode")
                    self.collectionView?.collectionViewLayout = self.createIconLayout()
                    self.reloadData()
                }))
            } else {
                sheet.addAction(UIAlertAction(title: "리스트", style: .default, handler: { _ in
                    self.viewMode = "list"
                    UserDefaults.standard.set("list", forKey: "viewMode")
                    self.collectionView?.collectionViewLayout = self.createListLayout()
                    self.reloadData()
                }))
            }
            sheet.addAction(UIAlertAction(title: "취소", style: .cancel))
            self.present(sheet, animated: true)
        }

        return action
    }
    
    private func refreshData() -> UIAction {
        let action = UIAction { _ in
            self.loadDailyBoxOfficeData()
        }
        
        return action
    }
    
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
        
        return "오늘: \(audienceCount) / 총: \(audienceAccumulation)"
    }
}
