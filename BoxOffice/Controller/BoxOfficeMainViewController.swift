//
//  BoxOfficeCollectionView.swift
//  BoxOffice
//
//  Created by EtialMoon, Minsup on 2023/07/31.
//

import UIKit

final class BoxOfficeMainViewController: UIViewController {
    enum Layout {
        enum IconSize {
            case small
            case medium
            case large
            
            var size: CGFloat {
                switch self {
                case .small:
                    return 0.25
                case .medium:
                    return 0.5
                case .large:
                    return 1.0
                }
            }
            
            mutating func up() {
                switch self {
                case .small:
                    self = .medium
                case .medium:
                    self = .large
                case .large:
                    self = .large
                }
            }
        }
        
        case list, icon
        
        mutating func toggle() {
            switch self {
            case .icon:
                self = .list
            case .list:
                self = .icon
            }
        }
    }
    
    private let boxOfficeMainView = BoxOfficeMainView()
    private var boxOfficeItems: [BoxOfficeItem] = []
    private var task: Task<Void, Never>?
    private var selectedDate = Date.yesterday
    private var selectedLayout = Layout.list
    
    override func loadView() {
        view = boxOfficeMainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        boxOfficeMainView.boxOfficeCollectionView.delegate = self
        boxOfficeMainView.boxOfficeCollectionView.dataSource = self
        NotificationCenter.default.addObserver(self, selector: #selector(setIconLayout), name: UIDevice.orientationDidChangeNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(setIconLayout), name: UIContentSizeCategory.didChangeNotification, object: nil)
        configureNavigation()
        configureRefreshControl()
        fetchData()
    }
    
    private func fetchData() {
        Task {
            boxOfficeMainView.boxOfficeCollectionView.isHidden = true
            boxOfficeMainView.indicatorView.startAnimating()
            await self.fetchBoxOfficeItems()
            boxOfficeMainView.indicatorView.stopAnimating()
            boxOfficeMainView.boxOfficeCollectionView.isHidden = false
        }
    }
    
    private func fetchBoxOfficeItems() async {
        do {
            let boxOffice: BoxOffice = try await NetworkManager.fetchData(fetchType: .boxOffice(date: selectedDate.networkFormat))
            
            let origin = self.boxOfficeItems
            let new = boxOffice.boxOfficeResult.boxOfficeItems

            if !origin.isEmpty {
                let differentIndexes = zip(origin, new).enumerated().compactMap { index, pair in
                    return pair.0 != pair.1 ? index : nil
                }

                let indexPaths = differentIndexes.map { index in
                    return IndexPath(item: index, section: 0)
                }
                
                self.boxOfficeItems = new
                
                boxOfficeMainView.collectionViewReloadItem(indexPaths: indexPaths)
            } else {
                self.boxOfficeItems = new
                boxOfficeMainView.collectionViewReloadData()
            }
        } catch {
            let alert = UIAlertController(
                title: "에러",
                message: "\(error.localizedDescription)",
                preferredStyle: .alert
            )
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    private func configureNavigation() {
        navigationItem.title = selectedDate.navigationFormat
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "날짜선택", style: .plain, target: self, action: #selector(tapSelectDateButton))
        
        navigationController?.isToolbarHidden = false
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let changeModeButton = UIBarButtonItem(title: "화면 모드 변경", style: .plain, target: self, action: #selector(tapChangeModeButton))
        toolbarItems = [flexibleSpace, changeModeButton, flexibleSpace]
    }
    
    @objc private func tapSelectDateButton() {
        let boxOfficeCalendarViewController = BoxOfficeCalendarViewController(date: selectedDate)
        boxOfficeCalendarViewController.delegate = self
        present(boxOfficeCalendarViewController, animated: true)
    }
    
    @objc private func tapChangeModeButton() {
        let sheet = UIAlertController(title: "화면모드변경", message: nil, preferredStyle: .actionSheet)
        let action = UIAlertAction(
            title: selectedLayout == .list ? "아이콘" : "리스트",
            style: .default,
            handler: { [weak self] _ in
                guard let self else { return }
                self.selectedLayout.toggle()
                switch self.selectedLayout {
                case .list:
                    self.setListLayout()
                case .icon:
                    self.setIconLayout()
                }
            }
        )
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        sheet.addAction(action)
        sheet.addAction(cancel)
        present(sheet, animated: true)
    }
    
    func setListLayout() {
        self.boxOfficeMainView.configureCollectionViewListLayout()
        self.boxOfficeMainView.collectionViewReloadData()
    }
    
    @objc func setIconLayout() {
        guard selectedLayout == .icon else { return }
        
        //iconSize 계산
        var iconSizeWidth: Layout.IconSize
        var iconSizeHeight: Layout.IconSize
        let orientation  = view.window?.windowScene?.interfaceOrientation
        let dynamicType = traitCollection.preferredContentSizeCategory
        
        if orientation == .landscapeRight || orientation == .landscapeLeft {
            iconSizeWidth = .small
            iconSizeHeight = .medium
        } else {
            iconSizeWidth = .medium
            iconSizeHeight = .small
        }
        
        if dynamicType >= .accessibilityMedium {
            iconSizeWidth.up()
            iconSizeHeight.up()
        }
        
        self.boxOfficeMainView.configureCollectionViewIconLayout(
            size: CGSize(
                width: iconSizeWidth.size,
                height: iconSizeHeight.size)
        )
        self.boxOfficeMainView.collectionViewReloadData()
    }
}

// MARK: - CollectionViewRefreshControl
extension BoxOfficeMainViewController {
    private func configureRefreshControl() {
        boxOfficeMainView.boxOfficeCollectionView.refreshControl = UIRefreshControl()
        boxOfficeMainView.boxOfficeCollectionView.refreshControl?.addTarget(self, action: #selector(handleRefreshControl), for: .valueChanged)
    }
    
    @objc private func handleRefreshControl() {
        task?.cancel()        
        task = Task {            
            await self.fetchBoxOfficeItems()
            self.boxOfficeMainView.boxOfficeCollectionView.refreshControl?.endRefreshing()
        }
    }
}

// MARK: - CollectionViewDataSource
extension BoxOfficeMainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch selectedLayout {
        case .list:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BoxOfficeCollectionViewListCell.identifier, for: indexPath) as? BoxOfficeCollectionViewListCell else { return UICollectionViewCell() }
            
            guard let boxOfficeItem = boxOfficeItems[safe: indexPath.row] else {
                return UICollectionViewCell()
            }
            
            cell.configureCell(boxOfficeItem: boxOfficeItem)
            
            return cell
        case .icon:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BoxOfficeCollectionViewIconCell.identifier, for: indexPath) as? BoxOfficeCollectionViewIconCell else { return UICollectionViewCell() }
            
            guard let boxOfficeItem = boxOfficeItems[safe: indexPath.row] else {
                return UICollectionViewCell()
            }
            
            cell.configureCell(boxOfficeItem: boxOfficeItem)
            
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return boxOfficeItems.count
    }
}

// MARK: - CollectionViewDelegate
extension BoxOfficeMainViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let boxOfficeItem = boxOfficeItems[safe: indexPath.row] else { return }
        
        let movieDetailViewController = MovieDetailViewController(boxOfficeItem: boxOfficeItem)        
        navigationController?.pushViewController(movieDetailViewController, animated: true)
    }
}

// MARK: - BoxOfficeCalendarViewControllerDelegate
extension BoxOfficeMainViewController: BoxOfficeCalendarViewControllerDelegate {
    func didTapSelectedDate(_ date: Date) {
        selectedDate = date
        navigationItem.title = date.navigationFormat
        fetchData()
    }
}
