//
//  BoxOfficeListViewController.swift
//  BoxOffice
//
//  Created by Rhode, Rilla on 2023/03/20.
//

import UIKit

final class BoxOfficeListViewController: UIViewController {
    private let server = NetworkManager.shared
    private let urlMaker = URLRequestMaker()
    private var boxOffice: BoxOffice?
    private var currentDate: String = Date.yesterday.convertString(isFormatted: false)
    
    private let loadingIndicatorView: UIActivityIndicatorView = {
        let loadingIndicatorView = UIActivityIndicatorView(style: .large)
        loadingIndicatorView.color = .systemGray3
        loadingIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        loadingIndicatorView.hidesWhenStopped = true
        
        return loadingIndicatorView
    }()
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 0
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(CustomCollectionViewListCell.self,
                                forCellWithReuseIdentifier: CustomCollectionViewListCell.identifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        configureLayout()
        loadingIndicatorView.startAnimating()
        configureViewController()
        configureCollectionView()
        configureRefreshControl()
    }

    private func configureUI() {
        view.addSubview(collectionView)
        view.addSubview(loadingIndicatorView)
    }
    
    private func configureLayout() {
        NSLayoutConstraint.activate([
            loadingIndicatorView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            loadingIndicatorView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            loadingIndicatorView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            loadingIndicatorView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    private func configureCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        
        fetchBoxOfficeData { [weak self] in
            DispatchQueue.main.async {
                self?.loadingIndicatorView.stopAnimating()
                self?.collectionView.reloadData()
                self?.collectionView.refreshControl?.endRefreshing()
            }
        }
    }
    
    private func configureViewController() {
        view.backgroundColor = .white
        title = currentDate.formatDateString(format: DateFormat.yearMonthDay)
        
        let selectDateButton: UIBarButtonItem = {
            let button = UIBarButtonItem(title: "날짜 선택",
                                         style: .plain,
                                         target: self,
                                         action: #selector(presentSelectDateModal))
            return button
        }()
        self.navigationItem.rightBarButtonItem = selectDateButton
    }
    
    @objc private func presentSelectDateModal() {
        let modal = CalendarViewController(currentDate)
        modal.delegate = self
        
        self.present(modal, animated: true)
    }
    
    private func fetchBoxOfficeData(completion: @escaping () -> Void) {
        guard let request = urlMaker.makeBoxOfficeURLRequest(date: currentDate) else { return }
        
        server.startLoad(request: request, mime: "json") { [weak self] result in
            let decoder = DecodeManager()
            do {
                guard let verifiedFetchingResult = try self?.verifyResult(result: result) else { return }
                let decodedFile = decoder.decodeJSON(data: verifiedFetchingResult, type: BoxOffice.self)
                let verifiedDecodingResult = try self?.verifyResult(result: decodedFile)
                
                self?.boxOffice = verifiedDecodingResult
                completion()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
 
    private func verifyResult<T, E: Error>(result: Result<T, E>) throws -> T? {
        switch result {
        case .success(let data):
            return data
        case .failure(let error):
            throw error
        }
    }
    
    private func configureRefreshControl() {
        collectionView.refreshControl = UIRefreshControl()
        collectionView.refreshControl?.addTarget(self,
                                                 action: #selector(handleRefreshControl),
                                                 for: .valueChanged)
    }
    
    @objc private func handleRefreshControl() {
        self.currentDate = Date.yesterday.convertString(isFormatted: false)
        configureViewController()
        configureCollectionView()
    }
}

extension BoxOfficeListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let count = boxOffice?.boxOfficeResult.dailyBoxOfficeList.count else { return 0 }
        
        return count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let dailyBoxOffice = self.boxOffice?.boxOfficeResult.dailyBoxOfficeList[index: indexPath.item]
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCollectionViewListCell.identifier, for: indexPath) as? CustomCollectionViewListCell else { return CustomCollectionViewListCell() }
        
        cell.configureDailyBoxOffice(dailyBoxOffice: dailyBoxOffice)

        return cell
    }
}

extension BoxOfficeListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width
        let height = collectionView.frame.height
        
        let itemsPerRow: CGFloat = 1
        let itemsPerColumn: CGFloat = 8.5
       
        let cellWidth = width / itemsPerRow
        let cellHeight = height / itemsPerColumn
        
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        guard let movieCode = self.boxOffice?.boxOfficeResult.dailyBoxOfficeList[index: indexPath.item]?.movieCode else {
            return
        }
        let detailMovieViewController = DetailMovieViewController(movieCode: movieCode)
        
        navigationController?.pushViewController(detailMovieViewController, animated: true)
    }
}

extension BoxOfficeListViewController: CalendarViewControllerDelegate {
    func deliverData(_ data: String) {
        self.currentDate = data
        
        configureViewController()
        configureCollectionView()
    }
}
