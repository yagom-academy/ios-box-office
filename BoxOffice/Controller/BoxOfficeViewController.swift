//
//  BoxOfficeViewController.swift
//  BoxOffice
//
//  Created by Christy, Hyemory on 2023/03/20.
//

import UIKit

final class BoxOfficeViewController: UIViewController {
    enum LayoutMode {
        case list
        case icon
        
        var title: String {
            switch self {
            case .list:
                return "리스트"
            case .icon:
                return "아이콘"
            }
        }
    }
    
    private var boxOffice: BoxOffice?
    private let networkManager = NetworkManager()
    private var currentLayoutMode = LayoutMode.list
    private var isReceivingBoxOffice = false

    private lazy var collectionView = UICollectionView(frame: .zero,
                                                       collectionViewLayout: UICollectionViewFlowLayout())
    private var collectionViewLeadingConstraint: NSLayoutConstraint?
    private var collectionViewTrailingConstraint: NSLayoutConstraint?
    
    private let dateFormatterWithHyphen = {
        let formatter = DateFormatter()
        
        formatter.dateFormat = "yyyy-MM-dd"
        
        return formatter
    }()
    
    private let dateFormatterWithoutHyphen = {
        let formatter = DateFormatter()
        
        formatter.dateFormat = "yyyyMMdd"
        
        return formatter
    }()
    
    private let loadingView: LoadingView = {
        let view = LoadingView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
      }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUIOption()
        fetchBoxOffice(targetDate: Date().showYesterdayDate(formatter: dateFormatterWithoutHyphen))
        configureCollectionView()
        configureRefreshControl()
    }
    
    private func configureUIOption() {
        let navigationRightButton = UIBarButtonItem(title: "날짜선택",
                                                    style: .plain,
                                                    target: self,
                                                    action: #selector(selectSearchDate))
        let backBarButtonItem = UIBarButtonItem(title: "",
                                                style: .plain,
                                                target: self,
                                                action: nil)

        view.backgroundColor = .systemBackground
        navigationItem.title = Date().showYesterdayDate(formatter: dateFormatterWithHyphen)
        navigationItem.rightBarButtonItem = navigationRightButton
        navigationItem.backBarButtonItem = backBarButtonItem
        
        configureToolBarButton()
    }
    
    @objc private func selectSearchDate() {
        let calendarViewController = CalendarViewController(currentDate: navigationItem.title,
                                                            dateFormatter: dateFormatterWithHyphen)
        
        calendarViewController.delegate = self
        
        self.present(calendarViewController, animated: true)
    }
    
    private func fetchBoxOffice(targetDate: String) {
        let urlRequest = EndPoint.dailyBoxOffice(date: targetDate).asURLRequest()
        
        if isReceivingBoxOffice == false {
            loadingView.isLoading = true
        }
        
        networkManager.fetchData(urlRequest: urlRequest, type: BoxOffice.self) { [weak self] result in
            switch result {
            case .success(let boxOfficeInfo):
                self?.boxOffice = boxOfficeInfo
                
                DispatchQueue.main.async {
                    self?.collectionView.reloadData()
                    self?.loadingView.isLoading = false
                    self?.isReceivingBoxOffice = true
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.displayAlert(from: error)
                }
            }
        }
    }
    
    private func displayAlert(from error: Error) {
        guard let networkingError = error as? NetworkingError else { return }
        
        let alert = UIAlertController(title: networkingError.description,
                                      message: "모리스티에게 문의해 주세요.",
                                      preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "닫기", style: .cancel))
        present(alert, animated: true)
    }
}

// MARK: - BoxOfficeListCell 등록 및 DataSource 설정

extension BoxOfficeViewController {
    private func switchLayout() {
        collectionViewLeadingConstraint?.isActive = false
        collectionViewTrailingConstraint?.isActive = false
        
        switch currentLayoutMode {
        case .list:
            collectionViewLeadingConstraint = collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor)
            collectionViewTrailingConstraint = collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        case .icon:
            collectionViewLeadingConstraint = collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10)
            collectionViewTrailingConstraint = collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10)
        }
        
        collectionViewLeadingConstraint?.isActive = true
        collectionViewTrailingConstraint?.isActive = true
    }
    
    private func configureCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        
        view.addSubview(collectionView)
        view.addSubview(loadingView)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            loadingView.leftAnchor.constraint(equalTo: self.collectionView.leftAnchor),
            loadingView.rightAnchor.constraint(equalTo: self.collectionView.rightAnchor),
            loadingView.bottomAnchor.constraint(equalTo: self.collectionView.bottomAnchor),
            loadingView.topAnchor.constraint(equalTo: self.collectionView.topAnchor),
        ])
        
        collectionViewLeadingConstraint = collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        collectionViewTrailingConstraint = collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        collectionViewLeadingConstraint?.isActive = true
        collectionViewTrailingConstraint?.isActive = true
        
        collectionView.register(BoxOfficeListCell.self, forCellWithReuseIdentifier: BoxOfficeListCell.identifier)
        collectionView.register(BoxOfficeIconCell.self, forCellWithReuseIdentifier: BoxOfficeIconCell.identifier)
    }
}

// MARK: - Refresh

extension BoxOfficeViewController {
    private func configureRefreshControl() {
        let refresh = UIRefreshControl()
        
        refresh.addTarget(self, action: #selector(handleRefreshControl), for: .valueChanged)
        collectionView.refreshControl = refresh
    }
    
    @objc private func handleRefreshControl() {
        let yesterday = Date().showYesterdayDate(formatter: dateFormatterWithHyphen)
        
        fetchBoxOffice(targetDate: yesterday.removeHyphen())
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) { [weak self] in
            self?.navigationItem.title = yesterday
            self?.collectionView.refreshControl?.endRefreshing()
        }
    }
}

// MARK: - Data Source

extension BoxOfficeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let boxOffice = self.boxOffice else { return 0 }
        
        return boxOffice.result.dailyBoxOfficeList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch currentLayoutMode {
        case .list:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BoxOfficeListCell.identifier, for: indexPath) as? BoxOfficeListCell,
                  let boxOfficeItem = boxOffice?.result.dailyBoxOfficeList[safe: indexPath.item] else { return UICollectionViewCell() }
            
            cell.configure(with: boxOfficeItem)
            
            return cell
        case .icon:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BoxOfficeIconCell.identifier, for: indexPath) as? BoxOfficeIconCell,
                  let boxOfficeItem = boxOffice?.result.dailyBoxOfficeList[safe: indexPath.item] else { return UICollectionViewCell() }
            
            cell.configure(with: boxOfficeItem)
            
            return cell
        }
    }
}

// MARK: - Delegate Flow Layout

extension BoxOfficeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        switch currentLayoutMode {
        case .list:
            return CGSize(width: view.bounds.width, height: view.bounds.height / 12)
        case .icon:
            let padding: CGFloat = 20
            let collectionViewSize = collectionView.frame.size.width - padding
            
            return CGSize(width: collectionViewSize / 2, height: collectionViewSize / 2)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        switch currentLayoutMode {
        case .list:
            return 0
        case .icon:
            return 10
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movieInfoViewController = MovieInfoViewController(movieCode: boxOffice?.result.dailyBoxOfficeList[safe: indexPath.item]?.movieCode ?? "")
        
        collectionView.deselectItem(at: indexPath, animated: true)
        navigationController?.pushViewController(movieInfoViewController, animated: true)
    }
}

// MARK: - DateUpdatableDelegate

extension BoxOfficeViewController: DateUpdatableDelegate {
    func update(date: Date) {
        navigationItem.title = date.showSelectedDate(formatter: dateFormatterWithHyphen)
        
        guard let targetDate = navigationItem.title?.removeHyphen() else { return }
        
        fetchBoxOffice(targetDate: targetDate)
    }
}

// MARK: - Tool Bar
extension BoxOfficeViewController {
    private func configureToolBarButton() {
        let toolBarButton = UIBarButtonItem(title: "화면 모드 변경",
                                            style: .plain,
                                            target: self,
                                            action: #selector(changeLayoutMode))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace,
                                            target: nil,
                                            action: nil)
        
        navigationController?.isToolbarHidden = false
        toolbarItems = [flexibleSpace, toolBarButton, flexibleSpace]
    }
    
    @objc private func changeLayoutMode() {
        let alert = UIAlertController(title: "화면모드변경", message: nil, preferredStyle: .actionSheet)
        let modeTitle = currentLayoutMode.title
        let modeAction = UIAlertAction(title: modeTitle, style: .default) { [weak self] _ in
            self?.switchCurrentLayoutMode()
        }
        let cancelAction = UIAlertAction(title: "취소", style: .cancel)
        
        alert.addAction(modeAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true)
    }
    
    private func switchCurrentLayoutMode() {
        DispatchQueue.main.async { [weak self] in
            self?.switchLayout()
            self?.collectionView.reloadData()
        }
        
        currentLayoutMode = currentLayoutMode == .list ? .icon : .list
    }
}
