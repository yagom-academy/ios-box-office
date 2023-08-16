//
//  ViewController.swift
//  BoxOffice
//
//  Created by Yetti, Maxhyunm on 2023/07/24.
//

import UIKit

final class BoxOfficeViewController: UIViewController, URLSessionDelegate {
    private var networkingManager: NetworkingManager?
    private var refreshControl = UIRefreshControl()
    private var dataSource: UICollectionViewDiffableDataSource<NetworkConfiguration, BoxOfficeEntity.BoxOfficeResult.DailyBoxOffice>?
    private var date: Date = Calendar.current.date(byAdding: .day, value: -1, to: Date()) ?? Date()

    private let collectionView: UICollectionView = {
        let configuration = UICollectionLayoutListConfiguration(appearance: .plain)
        let layout = UICollectionViewCompositionalLayout.list(using: configuration)
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.register(BoxOfficeRankingListCell.self, forCellWithReuseIdentifier: BoxOfficeRankingListCell.cellIdentifier)
        view.register(BoxOfficeRankingIconCell.self, forCellWithReuseIdentifier: BoxOfficeRankingIconCell.cellIdentifier)

        return view
    }()
    
    private let indicatorView: UIActivityIndicatorView = {
        let indicatorView = UIActivityIndicatorView()
        indicatorView.style = .large
        indicatorView.translatesAutoresizingMaskIntoConstraints = false
        
        return indicatorView
    }()
    
    private var isLoading: Bool = true {
        willSet(newValue) {
            if newValue == true {
                indicatorView.isHidden = false
                indicatorView.startAnimating()
            } else {
                indicatorView.isHidden = true
                indicatorView.stopAnimating()
            }
        }
    }
    
    private var isListMode = true {
        didSet {
            setUpCollectionViewLayout()
            setUpDataSource()
            passFetchedData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        setUpUI()
        setUpCollectionView()
        setUpDataSource()
        setUpNetwork()
        passFetchedData()
    }
}

extension BoxOfficeViewController {
    private func setUpUI() {
        let safeArea = view.safeAreaLayoutGuide
        let dateSelectionButton = UIBarButtonItem(title: "날짜선택", style: .plain, target: self, action: #selector(showCalendar))
        let modeChangeButton = UIBarButtonItem(title: "화면 모드 변경", style: .plain, target: self, action: #selector(hitChangeModeButton))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        
        view.backgroundColor = .systemBackground
        view.addSubview(collectionView)
        view.addSubview(indicatorView)
        
        self.navigationController?.isToolbarHidden = false
        self.toolbarItems = [flexibleSpace, modeChangeButton, flexibleSpace]
        self.title = getDateString(format: Namespace.dateWithHyphen)
        self.navigationItem.rightBarButtonItem = dateSelectionButton
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            
            indicatorView.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            indicatorView.centerYAnchor.constraint(equalTo: safeArea.centerYAnchor)
        ])
    }
    
    private func setUpCollectionViewLayout() {
        if isListMode {
            let configuration = UICollectionLayoutListConfiguration(appearance: .plain)
            let layout = UICollectionViewCompositionalLayout.list(using: configuration)
            
            collectionView.collectionViewLayout = layout
        } else {
            let layout = UICollectionViewFlowLayout()
            let width = (view.frame.width - 45) / 2.0
            
            layout.sectionInset = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
            layout.minimumLineSpacing = 10
            layout.minimumInteritemSpacing = 15
            layout.itemSize = CGSize(width: width, height: width)
            
            collectionView.collectionViewLayout = layout
        }
    }
    
    @objc func showCalendar(_ sender: UIButton) {
        let viewController = CalendarViewController(date)
        viewController.delegate = self
        viewController.modalPresentationStyle = UIModalPresentationStyle.automatic
        
        self.present(viewController, animated: true)
    }
    
    @objc func hitChangeModeButton() {
        let mode: String = isListMode == true ? "아이콘" : "리스트"
        let alert = UIAlertController(title: "화면 모드 변경", message: nil, preferredStyle: .actionSheet)
        let modeChangeAction = UIAlertAction(title: mode, style: .default) { _ in
            self.isListMode.toggle()
        }
        let cancelAction = UIAlertAction(title: "취소", style: .cancel)
        
        alert.addAction(modeChangeAction)
        alert.addAction(cancelAction)
        present(alert, animated: true)
    }
}

extension BoxOfficeViewController {
    private func getDateString(format: String) -> String {
        return DateFormatter().formatToString(from: date, with: format)
    }
    
    struct Namespace {
        static let dateWithHyphen = "YYYY-MM-dd"
        static let dateWithoutHyphen = "YYYYMMdd"
    }
}

extension BoxOfficeViewController {
    private func setUpCollectionView() {
        collectionView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
    }
    
    private func setUpDataSource() {
        if isListMode {
            dataSource = UICollectionViewDiffableDataSource<NetworkConfiguration, BoxOfficeEntity.BoxOfficeResult.DailyBoxOffice>(collectionView: self.collectionView) { (collectionView, indexPath, data) -> UICollectionViewCell? in
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BoxOfficeRankingListCell.cellIdentifier, for: indexPath) as? BoxOfficeRankingListCell else {
                    return BoxOfficeRankingListCell()
                }
                
                cell.setUpLabelText(data)
                
                return cell
            }
        } else {
            dataSource = UICollectionViewDiffableDataSource<NetworkConfiguration, BoxOfficeEntity.BoxOfficeResult.DailyBoxOffice>(collectionView: self.collectionView) { (collectionView, indexPath, data) -> UICollectionViewCell? in
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BoxOfficeRankingIconCell.cellIdentifier, for: indexPath) as? BoxOfficeRankingIconCell else {
                    return BoxOfficeRankingIconCell()
                }

                cell.setUpLabelText(data)

                return cell
            }
        }
    }
    
    private func setUpDataSnapshot(_ data: [BoxOfficeEntity.BoxOfficeResult.DailyBoxOffice]) {
        var snapshot = NSDiffableDataSourceSnapshot<NetworkConfiguration, BoxOfficeEntity.BoxOfficeResult.DailyBoxOffice>()
        
        snapshot.appendSections([.boxOffice(getDateString(format: Namespace.dateWithoutHyphen))])
        snapshot.appendItems(data)
        dataSource?.apply(snapshot)
    }
    
    @objc private func refresh() {
        passFetchedData()
    }
}

extension BoxOfficeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let movieCode = dataSource?.itemIdentifier(for: indexPath)?.movieCode,
              let movieName = dataSource?.itemIdentifier(for: indexPath)?.movieName else {
            return
        }
        
        let movieDetailViewController = MovieDetailViewController(movieCode: movieCode, movieName: movieName)
        
        navigationController?.pushViewController(movieDetailViewController, animated: true)
    }
}

extension BoxOfficeViewController {
    private func setUpNetwork() {
        let session: URLSession = {
            let configuration = URLSessionConfiguration.default
            configuration.waitsForConnectivity = true
            
            return URLSession(configuration: configuration, delegate: self, delegateQueue: nil)
        }()
        
        networkingManager = NetworkingManager(session)
    }
    
    private func passFetchedData() {
        isLoading = true
        let date = getDateString(format: Namespace.dateWithoutHyphen)

        networkingManager?.load(NetworkConfiguration.boxOffice(date)) { [weak self] (result: Result<Data, NetworkingError>) in
            switch result {
            case .success(let data):
                do {
                    let decodedData: BoxOfficeEntity = try DecodingManager.shared.decode(data)
                    self?.setUpDataSnapshot(decodedData.boxOfficeResult.dailyBoxOfficeList)
                } catch {
                    print(DecodingError.decodingFailure.description)
                }
            case .failure(let error):
                print(error.description)
            }
            
            DispatchQueue.main.async {
                self?.isLoading = false
                self?.refreshControl.endRefreshing()
            }
        }
    }
}

protocol BoxOfficeDelegate: AnyObject {
    func setUpDate(_ date: Date)
}

extension BoxOfficeViewController: BoxOfficeDelegate {
    func setUpDate(_ date: Date) {
        self.date = date
        self.title = getDateString(format: Namespace.dateWithHyphen)

        passFetchedData()
    }
}
