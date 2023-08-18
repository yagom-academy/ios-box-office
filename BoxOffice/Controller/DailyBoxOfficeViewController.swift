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
    private var targetDate: Date = Date.yesterday
    
    private var leadingConstraint: NSLayoutConstraint!
    private var trailingConstraint: NSLayoutConstraint!
    
    private var viewMode: BoxOfficeViewMode = .list {
        didSet {
            updateCollectionViewLayout()
            updateAutoLayout()
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
        
        navigationController?.toolbar.scrollEdgeAppearance = UIToolbarAppearance()
        
        setNavigationTitle()
    }
    
    @objc private func presentCalendarView() {
        let calendarViewController = CalendarViewController(date: targetDate)
        calendarViewController.delegate = self
        
        present(calendarViewController, animated: true)
    }
    
    @objc private func presentActionSheet() {
        let actionSheet: UIAlertController = UIAlertController(title: "화면 모드 변경", message: nil, preferredStyle: .actionSheet)
        let alertActionCancel: UIAlertAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        
        BoxOfficeViewMode.allCases.filter{ $0 != viewMode }.forEach { mode in
            let alertAction: UIAlertAction = UIAlertAction(title: "\(mode)", style: .default) { _ in
                self.viewMode = mode
            }
            
            actionSheet.addAction(alertAction)
        }
        
        actionSheet.addAction(alertActionCancel)
        
        present(actionSheet, animated: true)
    }
    
    private func setNavigationTitle() {
        navigationItem.title = targetDate.convertString(format: "yyyy-MM-dd")
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
        leadingConstraint = collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor)
        trailingConstraint = collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        
        NSLayoutConstraint.activate([
            loadingView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            loadingView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            loadingView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            loadingView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            leadingConstraint,
            trailingConstraint,
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func updateAutoLayout() {
        switch viewMode {
        case .list:
            leadingConstraint.constant = CGFloat(0)
            trailingConstraint.constant = CGFloat(0)
        case .grid:
            leadingConstraint.constant = CGFloat(10)
            trailingConstraint.constant = CGFloat(-10)
        }
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
        let targetDateString = targetDate.convertString(format: "yyyyMMdd")
        
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
        
        switch viewMode {
        case .list:
            let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout
            layout?.minimumLineSpacing = 0
            layout?.minimumInteritemSpacing = 0
        case .grid:
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
        guard let count = boxOfficeData?.boxOfficeResult.dailyBoxOfficeList.count else { return 0 }
        
        return count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let data = boxOfficeData?.boxOfficeResult.dailyBoxOfficeList[index: indexPath.item] else {
            return UICollectionViewCell()
        }
        
        switch viewMode {
        case .list:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DailyBoxOfficeCollectionViewListCell.identifier, for: indexPath) as? DailyBoxOfficeCollectionViewListCell else {
                return UICollectionViewCell()
            }
            
            cell.configureCell(data: data)
            
            return cell
        case .grid:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DailyBoxOfficeCollectionViewGridCell.identifier, for: indexPath) as? DailyBoxOfficeCollectionViewGridCell else {
                return UICollectionViewCell()
            }
            
            cell.configureCell(data: data)
            
            return cell
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch viewMode {
            
        case .list:
            let width: CGFloat = collectionView.frame.width
            var height: CGFloat = collectionView.frame.height * 0.1
            
            guard let data = boxOfficeData?.boxOfficeResult.dailyBoxOfficeList[index: indexPath.item] else {
                return CGSize(width: width, height: height)
            }
            
            let cell = DailyBoxOfficeCollectionViewListCell(frame: CGRect(x: 0, y: 0, width: width, height: height))
            cell.titleLabel.text = data.movieName
            
            cell.layoutIfNeeded()
            
            let titleLabelSize = cell.titleLabel.intrinsicContentSize
            height += titleLabelSize.height
            
            return CGSize(width: width, height: height)
        case .grid:
            let width: CGFloat = collectionView.frame.width / 2.1
            let height: CGFloat = width
            
            return CGSize(width: width, height: height)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let data = boxOfficeData?.boxOfficeResult.dailyBoxOfficeList[index: indexPath.item] else {
            return
        }
        
        let movieInformationViewController: MovieInformationViewController = MovieInformationViewController(data: data)
        
        collectionView.deselectItem(at: indexPath, animated: true)
        
        navigationController?.pushViewController(movieInformationViewController, animated: true)
    }
}
