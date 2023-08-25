//
//  BoxOfficeViewController.swift
//  BoxOffice
//
//  Created by kjs on 13/01/23.
//  Last modified by Dasan & Whales.

import UIKit
import OSLog

private enum Section: Hashable {
    case main
}

private enum CollectionViewStyle {
    case list
    case grid
}

final class BoxOfficeViewController: UIViewController {
    private let yesterday = TargetDate(dayFromNow: -1)
    private var items = [BoxOfficeData]()
    
    private var collectionView: UICollectionView! = nil
    private var dataSource: UICollectionViewDiffableDataSource<Section, BoxOfficeData>! = nil
    private let activityIndicatorView = UIActivityIndicatorView()
    private var collectionViewStyle: CollectionViewStyle = .list
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureHierarchy(style: collectionViewStyle)
        configureActivityIndicatorView()
        startActivityIndicator()
        loadData()
        configureDataSource(style: collectionViewStyle)
        configureNavigationItem(title: yesterday.formattedWithHyphen())
        configureToolbar()
        
        collectionView.delegate = self
    }
    
    private func loadData() {
        let boxOfficeManager = BoxOfficeManager()
        
        boxOfficeManager.fetchBoxOfficeData(with: yesterday) { result in
            switch result {
            case .success(let items):
                DispatchQueue.main.async {
                    guard let items = items else { return }
                    self.items = items
                    self.applySnapshot()
                    self.stopActivityIndicator()
                }
            case .failure(let error):
                os_log("%{public}@", type: .default, error.localizedDescription)
            }
        }
    }
}

extension BoxOfficeViewController {
    private func applySnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, BoxOfficeData>()
        snapshot.appendSections([.main])
        snapshot.appendItems(items)
        
        DispatchQueue.main.async {
            self.dataSource.apply(snapshot, animatingDifferences: true)
        }
    }
    
    private func configureHierarchy(style: CollectionViewStyle) {
        if style == .list {
            collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createListLayout())
        } else {
            collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createGridLayout())
        }
        
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        view.addSubview(collectionView)
        configureRefreshControl()
    }
    
    private func createListLayout() -> UICollectionViewLayout {
        let configuration = UICollectionLayoutListConfiguration(appearance: .plain)
        
        return UICollectionViewCompositionalLayout.list(using: configuration)
    }
    
    private func createGridLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5),
                                             heightDimension: .fractionalHeight(1.0))
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .fractionalHeight(0.2))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                       subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)

        let layout = UICollectionViewCompositionalLayout(section: section)
        
        return layout
    }
    
    private func configureDataSource(style: CollectionViewStyle) {
        if style == .list {
            let cellRegistration = UICollectionView.CellRegistration<BoxOfficeCell, BoxOfficeData> { (cell, indexPath, item) in
                let rankIntensityText = self.configureRankIntensity(with: item)
                cell.updateLabel(with: item, rankIntensityText)
            }
            
            dataSource = UICollectionViewDiffableDataSource<Section, BoxOfficeData>(collectionView: collectionView) {
                (collectionView: UICollectionView, indexPath: IndexPath, identifier: BoxOfficeData) -> UICollectionViewListCell? in
                return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: identifier)
            }
            
        } else {
            let cellRegistration = UICollectionView.CellRegistration<BoxOfficeGridCell, BoxOfficeData> { (cell, indexPath, item) in
                let rankIntensityText = self.configureRankIntensity(with: item)
                cell.updateLabel(with: item, rankIntensityText)
            }
            
            dataSource = UICollectionViewDiffableDataSource<Section, BoxOfficeData>(collectionView: collectionView) {
                (collectionView: UICollectionView, indexPath: IndexPath, identifier: BoxOfficeData) -> UICollectionViewCell? in
                return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: identifier)
            }
        }
        
        applySnapshot()
    }
    
    private func configureRankIntensity(with boxOfficeData: BoxOfficeData) -> NSMutableAttributedString {
        var text: String
        var attributedString: NSMutableAttributedString
        let rankOldOrNew = boxOfficeData.rankOldOrNew
        
        guard let rankIntensity = Int(boxOfficeData.rankIntensity) else {
            return NSMutableAttributedString(string: "")
        }
        
        if rankOldOrNew.rawValue == RankOldOrNew.old.rawValue {
            if rankIntensity < 0 {
                text = "▼\(-rankIntensity)"
                attributedString = NSMutableAttributedString(string: text)
                attributedString.addAttribute(.foregroundColor, value: UIColor.systemBlue, range: (text as NSString).range(of: "▼"))
                
                return attributedString
            } else if rankIntensity > 0 {
                text = "▲\(rankIntensity)"
                attributedString = NSMutableAttributedString(string: text)
                attributedString.addAttribute(.foregroundColor, value: UIColor.systemRed, range: (text as NSString).range(of: "▲"))
                
                return attributedString
            } else {
                return NSMutableAttributedString(string: "-")
            }
        } else {
            text = "신작"
            attributedString = NSMutableAttributedString(string: text)
            attributedString.addAttribute(.foregroundColor, value: UIColor.systemRed, range: (text as NSString).range(of: "신작"))
            
            return attributedString
        }
    }
    
    private func configureNavigationItem(title: String) {
        navigationItem.title = title
    }
    
    private func configureToolbar() {
        navigationController?.isToolbarHidden = false
        
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let changeViewModeButton = UIBarButtonItem(title: "화면 모드 변경", style: .plain, target: self, action: #selector(tappedChangeViewModeButton))
        
        var items = [UIBarButtonItem]()
        
        items.append(flexibleSpace)
        items.append(changeViewModeButton)
        items.append(flexibleSpace)
        
        toolbarItems = items
    }
    
    @objc func tappedChangeViewModeButton() {
        showAlertController(currentStyle: collectionViewStyle)
    }
    
    private func showAlertController(currentStyle: CollectionViewStyle) {
        var message: String {
            switch currentStyle {
            case .list :
                return "아이콘"
            case .grid :
                return "리스트"
            }
        }
        
        let alert = UIAlertController(title: "화면모드변경", message: nil, preferredStyle: UIAlertController.Style.actionSheet)
        
        let changeAction = UIAlertAction(title: message, style: .default) { _ in
            self.changeMode()
        }
        let cancelAction = UIAlertAction(title: "취소", style: .cancel)
        
        alert.addAction(changeAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true)
    }
    
    private func changeMode() {
        if collectionViewStyle == .list {
            collectionViewStyle = .grid
        } else {
            collectionViewStyle = .list
        }
        
        collectionView.removeFromSuperview()

        configureHierarchy(style: collectionViewStyle)
        configureDataSource(style: collectionViewStyle)

        collectionView.delegate = self
    }
}

extension BoxOfficeViewController {
    private func configureActivityIndicatorView() {
        view.addSubview(activityIndicatorView)
        
        activityIndicatorView.style = .large
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            activityIndicatorView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicatorView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
    
    private func startActivityIndicator() {
        activityIndicatorView.startAnimating()
    }
    
    private func stopActivityIndicator() {
        activityIndicatorView.stopAnimating()
        activityIndicatorView.removeFromSuperview()
    }
    
    private func configureRefreshControl() {
        collectionView.refreshControl = UIRefreshControl()
        collectionView.refreshControl?.addTarget(self, action: #selector(handleRefreshControl), for: .valueChanged)
    }
    
    @objc func handleRefreshControl() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
            self.loadData()
            self.configureNavigationItem(title: self.yesterday.formattedWithHyphen())
            self.collectionView.refreshControl?.endRefreshing()
        }
    }
}

extension BoxOfficeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movieCode: String = items[indexPath.item].movieCode
        let movieInformationViewController = MovieInformationViewController(movieCode: movieCode)
        
        show(movieInformationViewController, sender: self)
    }
}
