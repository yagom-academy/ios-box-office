//
//  DailyBoxOfficeViewController.swift
//  BoxOffice
//
//  Created by kjs on 13/01/23.
//  last modified by Idinaloq, MARY

import UIKit

protocol CalendarDelegate: AnyObject {
    func updateBoxOffice(date: Date)
}

final class DailyBoxOfficeViewController: UIViewController {
    private var kobisOpenAPI: KobisOpenAPI = KobisOpenAPI()
    private var networkService: NetworkService = NetworkService()
    private var boxOfficeData: BoxOffice?
    private let loadingView: LoadingView = LoadingView()
    private var targetDate: Date = DateManager.fetchPastDate(dayAgo: 1)
    
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
    
    private func configureNavigationItem() {
        let logoutBarButtonItem = UIBarButtonItem(title: "날짜선택", style: .done, target: self, action: #selector(presentCalendarView))
        self.navigationItem.rightBarButtonItem  = logoutBarButtonItem
        setNavigationTitle()
    }
    
    private func setNavigationTitle() {
        navigationItem.title = DateManager.changeDateFormat(date: targetDate, format: "yyyy-MM-dd")
    }
    
    @objc func presentCalendarView() {
        let calendarViewController = CalendarViewController(date: targetDate)
        calendarViewController.delegate = self
        present(calendarViewController, animated: true)
    }
    
    private func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(DailyBoxOfficeCollectionViewCell.self,
                                forCellWithReuseIdentifier: DailyBoxOfficeCollectionViewCell.identifier)
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
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
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
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DailyBoxOfficeCollectionViewCell.identifier, for: indexPath) as? DailyBoxOfficeCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        guard let data = boxOfficeData,
              let data = data.boxOfficeResult.dailyBoxOfficeList[index: indexPath.item] else {
            return cell
        }
        
        cell.configureCell(data: data)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = collectionView.frame.width
        var height: CGFloat = collectionView.frame.height * 0.1
        
        guard let data = boxOfficeData,
              let data = data.boxOfficeResult.dailyBoxOfficeList[index: indexPath.item] else {
            return CGSize(width: width, height: height)
        }
        
        let cell = DailyBoxOfficeCollectionViewCell(frame: CGRect(x: 0, y: 0, width: width, height: height))
        
        cell.titleLabel.text = data.movieName
        cell.layoutIfNeeded()
        
        let titleLabelSize = cell.titleLabel.intrinsicContentSize
        
        height += titleLabelSize.height
        
        return CGSize(width: width, height: height)
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
