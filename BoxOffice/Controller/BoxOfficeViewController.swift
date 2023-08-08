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
    private let activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
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
        let selectDateButton = UIBarButtonItem(title: "날짜선택", style: .plain, target: self, action: #selector(didTapSelectDateButton))
        
        navigationItem.title = DateFormatter().dateString(for: boxOfficeManager.targetDate, with: DateFormatter.FormatCase.hyphen)
        navigationItem.rightBarButtonItem = selectDateButton
    }
    
    private func setupCollectionView() {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: verticalLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(BoxOfficeCollectionViewCell.self, forCellWithReuseIdentifier: BoxOfficeCollectionViewCell.identifier)
        collectionView.delegate = self
    }
    
    private func setupRefreshControl() {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(loadBoxOfficeData), for: .valueChanged)
        
        collectionView.refreshControl = refreshControl
    }
    
    @objc private func didTapSelectDateButton() {
        if #available(iOS 16.0, *) {
            let dateComponents = Calendar.current.dateComponents([.year, .month, .day], from: boxOfficeManager.targetDate)
            let calendarViewController = CalendarViewController(selectedDate: dateComponents)
            calendarViewController.delegate = self
            
            present(calendarViewController, animated: true)
        } else {
            return
        }
    }
    
    @objc private func loadBoxOfficeData() {
        boxOfficeManager.fetchBoxOffice { result in
            if result == false {
                DispatchQueue.main.async {
                    let alert = UIAlertController.errorAlert(NameSpace.fail, NameSpace.loadDataFail, actionTitle: NameSpace.check, actionType: .default)
                    
                    self.collectionView.refreshControl?.endRefreshing()
                    self.activityIndicator.stopAnimating()
                    self.present(alert, animated: false)
                }
                
                return
            }
            
            DispatchQueue.main.async {
                self.applySnapshot()
                self.collectionView.refreshControl?.endRefreshing()
                self.activityIndicator.stopAnimating()
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
        let movieName = boxOfficeManager.dailyBoxOffices[indexPath.item].movieTitle
        let movieDetailViewController = MovieDetailViewController(boxOfficeManager: boxOfficeManager, movieName: movieName ,movieCode: movieCode)
        
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

// MARK: CalendarViewControllerDelegate
extension BoxOfficeViewController: CalendarViewControllerDelegate {
    func selectedDate(date: DateComponents?) {
        guard let dateComponents = date,
              let selectedDate = dateComponents.date else {
            return
        }
        
        boxOfficeManager.setTargetDate(selectedDate)
        activityIndicator.startAnimating()
        loadBoxOfficeData()
        setupNavigation()
    }
}

// MARK: configure UI
extension BoxOfficeViewController {
    private func configureUI() {
        configureView()
    }
    
    private func configureView() {
        view.backgroundColor = .systemBackground
        view.addSubview(collectionView)
        view.addSubview(activityIndicator)
    }
}

// MARK: setup Constraint
extension BoxOfficeViewController {
    private func setupConstraint() {
        setupCollectionVeiwConstraint()
        setupActivityIndicatorConstraint()
    }
    
    private func setupCollectionVeiwConstraint() {
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func setupActivityIndicatorConstraint() {
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
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
