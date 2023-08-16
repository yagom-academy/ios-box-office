//
//  DailyBoxOfficeViewController.swift
//  BoxOffice
//
//  Created by kjs on 13/01/23.
//  last modified by Idinaloq, MARY

import UIKit

final class DailyBoxOfficeViewController: UIViewController {
    private var kobisOpenAPI: KobisOpenAPI = KobisOpenAPI()
    private var networkService: NetworkService = NetworkService()
    private var boxOfficeData: BoxOffice?
    private let loadingView: LoadingView = LoadingView()
    private var targetDate: Date = DateManager.fetchPastDate(dayAgo: 1)
    
    private var isListMode: Bool = true {
        didSet {
            updateCollectionViewLayout()
            collectionView.reloadData()
        }
    }
    
    private lazy var refreshControl: UIRefreshControl = {
        let refreshControl: UIRefreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        
        return refreshControl
    }()
    
    private let collectionView: UICollectionView = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        let collectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        layout.minimumLineSpacing = 0
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationItem()
        setupCollectionView()
        configureView()
        setUpAutoLayout()
        receiveData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.isToolbarHidden = false
    }
    
    private func configureNavigationItem() {
        let logoutBarButtonItem = UIBarButtonItem(title: "날짜선택", style: .done, target: self, action: #selector(presentCalendarView))
        self.navigationItem.rightBarButtonItem  = logoutBarButtonItem
        
        let toolBarButtonItem = UIBarButtonItem(title: "화면 모드 변경", style: .done, target: self, action: #selector(presentActionSheet))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        self.setToolbarItems([flexibleSpace, toolBarButtonItem, flexibleSpace], animated: true)
        
        let appearance = UIToolbarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .systemGray6
        navigationController?.toolbar.scrollEdgeAppearance = appearance
        
        setNavigationTitle()
    }
    
    @objc private func presentCalendarView() {
        let calendarViewController = CalendarViewController(date: targetDate)
        calendarViewController.delegate = self
        
        present(calendarViewController, animated: true)
    }
    
    @objc private func presentActionSheet() {
        let actionSheet: UIAlertController = UIAlertController(title: "화면 모드 변경", message: nil, preferredStyle: .actionSheet)
        let alertActionList: UIAlertAction = UIAlertAction(title: "리스트", style: .default) { _ in
            self.changeScreenMode()
        }
        let alertActionIcon: UIAlertAction = UIAlertAction(title: "아이콘", style: .default) { _ in
            self.changeScreenMode()
        }
        let alertActionCancel: UIAlertAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        
        if isListMode {
            actionSheet.addAction(alertActionIcon)
        } else {
            actionSheet.addAction(alertActionList)
        }
        actionSheet.addAction(alertActionCancel)
        
        present(actionSheet, animated: true)
    }
    
    private func setNavigationTitle() {
        navigationItem.title = DateManager.changeDateFormat(date: targetDate, format: "yyyy-MM-dd")
    }
    
    private func changeScreenMode() {
        isListMode = !isListMode
    }
    
    private func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(DailyBoxOfficeCollectionViewListCell.self,
                                forCellWithReuseIdentifier: DailyBoxOfficeCollectionViewListCell.identifier)
        collectionView.register(DailyBoxOfficeCollectionViewGridCell.self,
                                forCellWithReuseIdentifier: DailyBoxOfficeCollectionViewGridCell.identifier)
        collectionView.refreshControl = refreshControl
    }
    
    private func configureView() {
        view.addSubview(loadingView)
        view.addSubview(collectionView)
        view.backgroundColor = .systemBackground
    }
    
    private func setUpAutoLayout() {
        NSLayoutConstraint.activate([
            loadingView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            loadingView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            loadingView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            loadingView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func receiveData() {
        guard let urlRequest = receiveURLRequest() else { return }
        
        networkService.fetchData(urlRequest: urlRequest) { result in
            switch result {
            case .success(let data):
                self.decodeData(data)
                self.reloadCollectionView()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func receiveURLRequest() -> URLRequest? {
        let targetDateString = DateManager.changeDateFormat(date: targetDate, format: "yyyyMMdd")
        
        do {
            let urlRequest = try kobisOpenAPI.receiveURLRequest(serviceType: .dailyBoxOffice, queryItems: ["targetDt": targetDateString])
            
            return urlRequest
        } catch {
            print(error.localizedDescription)
            
            return nil
        }
    }
    
    private func decodeData(_ data: Data) {
        do {
            let decodedData = try JSONDecoder().decode(BoxOffice.self, from: data)
            boxOfficeData = decodedData
        } catch {
            print(error.localizedDescription)
        }
    }
    
    private func reloadCollectionView() {
        DispatchQueue.main.async { [weak self] in
            self?.loadingView.hide()
            self?.collectionView.reloadData()
            self?.refreshControl.endRefreshing()
        }
    }
    
    @objc private func refreshData() {
        receiveData()
    }
    
    private func updateCollectionViewLayout() {
        if isListMode {
            let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout
            layout?.minimumLineSpacing = 0
            layout?.minimumInteritemSpacing = 0
        } else {
            let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout
            layout?.minimumLineSpacing = 10
            layout?.minimumInteritemSpacing = 10
        }
    }
}

extension DailyBoxOfficeViewController: CalendarDelegate {
    func updateBoxOffice(date: Date) {
        targetDate = date
        receiveData()
        setNavigationTitle()
    }
}

extension DailyBoxOfficeViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if isListMode {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DailyBoxOfficeCollectionViewListCell.identifier, for: indexPath) as? DailyBoxOfficeCollectionViewListCell else {
                return UICollectionViewCell()
            }
            
            guard let data = boxOfficeData,
                  let data = data.boxOfficeResult.dailyBoxOfficeList[index: indexPath.item] else {
                return cell
            }
            
            cell.configureCell(data: data)
            
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DailyBoxOfficeCollectionViewGridCell.identifier, for: indexPath) as? DailyBoxOfficeCollectionViewGridCell else {
                return UICollectionViewCell()
            }
            
            guard let data = boxOfficeData,
                  let data = data.boxOfficeResult.dailyBoxOfficeList[index: indexPath.item] else {
                return cell
            }
            
            cell.configureCell(data: data)
            
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if isListMode {
            let width: CGFloat = collectionView.frame.width
            var height: CGFloat = collectionView.frame.height * 0.1
            
            guard let data = boxOfficeData,
                  let data = data.boxOfficeResult.dailyBoxOfficeList[index: indexPath.item] else {
                return CGSize(width: width, height: height)
            }
            
            let cell = DailyBoxOfficeCollectionViewListCell(frame: CGRect(x: 0, y: 0, width: width, height: height))
            cell.titleLabel.text = data.movieName
            
            cell.layoutIfNeeded()
            
            let titleLabelSize = cell.titleLabel.intrinsicContentSize
            height += titleLabelSize.height
            
            return CGSize(width: width, height: height)
        } else {
            let width: CGFloat = collectionView.frame.width / 2.1
            let height: CGFloat = width
            
            return CGSize(width: width, height: height)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let data = boxOfficeData,
              let data = data.boxOfficeResult.dailyBoxOfficeList[index: indexPath.item] else {
            return
        }
        
        let movieInformationViewController: MovieInformationViewController = MovieInformationViewController(data: data)
        
        collectionView.deselectItem(at: indexPath, animated: true)
        
        navigationController?.pushViewController(movieInformationViewController, animated: true)
    }
}
