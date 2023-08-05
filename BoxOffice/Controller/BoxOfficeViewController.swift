//
//  BoxOfficeViewController.swift
//  BoxOffice
//
//  Created by kyungmin, Erick on 2023/07/24.
//

import UIKit

final class BoxOfficeViewController: UIViewController {
    private let boxOfficeManager: BoxOfficeManager
    private var collectionView: UICollectionView!
    private var dailyBoxOfficeDataSource: UICollectionViewDiffableDataSource<Section, DailyBoxOffice>!
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.center = view.center
        
        return activityIndicator
    }()
    
    init(boxOfficeManager: BoxOfficeManager) {
        self.boxOfficeManager = boxOfficeManager

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigation()
        setupCollectionView()
        setupDataSource()
        setupRefreshControl()
        activityIndicator.startAnimating()
        loadBoxOfficeData()
        
        configureUI()
        setupConstraint()
    }
    
    private func setupNavigation() {
        self.navigationItem.title = DateFormatter().dateString(before: 1, with: DateFormatter.FormatCase.hyphen)
    }
    
    private func setupCollectionView() {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: verticalLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(BoxOfficeCollectionViewCell.self, forCellWithReuseIdentifier: BoxOfficeCollectionViewCell.identifier)
        collectionView.dataSource = dailyBoxOfficeDataSource
        collectionView.delegate = self
    }
    
    private func setupRefreshControl() {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(loadBoxOfficeData), for: .valueChanged)
        
        collectionView.refreshControl = refreshControl
    }
    
    @objc private func loadBoxOfficeData() {
        boxOfficeManager.fetchBoxOffice { [weak self] result in
            if result == false {
                DispatchQueue.main.async {
                    let alert = UIAlertController.errorAlert(NameSpace.fail, NameSpace.loadDataFail, actionTitle: NameSpace.check, actionType: .default)
                    
                    self?.collectionView.refreshControl?.endRefreshing()
                    self?.activityIndicator.stopAnimating()
                    self?.present(alert, animated: false)
                }
                
                return
            }
            
            DispatchQueue.main.async {
                self?.applySnapshot()
                self?.collectionView.refreshControl?.endRefreshing()
                self?.activityIndicator.stopAnimating()
            }
        }
    }
}

// MARK: CollectionView Layout
extension BoxOfficeViewController {
    private func verticalLayout() -> UICollectionViewCompositionalLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.2))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        
        return UICollectionViewCompositionalLayout(section: section)
    }
}

// MARK: CollectionView DataSource
extension BoxOfficeViewController {
    private func setupDataSource() {
        dailyBoxOfficeDataSource = UICollectionViewDiffableDataSource<Section, DailyBoxOffice>(collectionView: collectionView) { collectionView, indexPath, dailyBoxOffice in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BoxOfficeCollectionViewCell.identifier, for: indexPath) as? BoxOfficeCollectionViewCell else {
                return UICollectionViewCell()
            }
            
            cell.setupLabels(dailyBoxOffice)
            
            return cell
        }
    }
}

// MARK: CollectionView Delegate
extension BoxOfficeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movieCode = boxOfficeManager.dailyBoxOffices[indexPath.item].movieCode
        let movieDetailViewController = MovieDetailViewController(boxOfficeManager: boxOfficeManager, movieCode: movieCode)
        
        navigationController?.pushViewController(movieDetailViewController, animated: true)
    }
}

// MARK: CollectionView Snapshot
extension BoxOfficeViewController {
    private func applySnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, DailyBoxOffice>()
        snapshot.appendSections([.main])
        snapshot.appendItems(boxOfficeManager.dailyBoxOffices, toSection: .main)
        
        dailyBoxOfficeDataSource.apply(snapshot, animatingDifferences: true)
    }
}

// MARK: setup UI
extension BoxOfficeViewController {
    private func configureUI() {
        view.backgroundColor = .systemBackground
        view.addSubview(collectionView)
        view.addSubview(activityIndicator)
    }
    
    private func setupConstraint() {
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

// MARK: Name Space
extension BoxOfficeViewController {
    private enum NameSpace {
        static let fail = "실패"
        static let loadDataFail = "데이터 로드에 실패했습니다."
        static let check = "확인"
    }
}

// MARK: CollectionView Section
extension BoxOfficeViewController {
    private enum Section {
        case main
    }
}
