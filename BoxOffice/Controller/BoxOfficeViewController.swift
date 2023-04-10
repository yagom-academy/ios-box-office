//
//  ViewController.swift
//  BoxOffice
//
//  Created by goat, songjun on 13/01/23.
//

import UIKit

protocol CalendarDateDelegate: AnyObject {
    func receiveDate(date: String)
}

final class BoxOfficeViewController: UIViewController {
    let boxOfficeService = BoxOfficeService()
    private var provider = Provider()
    private var isCurrentListLayout: Bool = true
    let calendarViewController = CalendarViewController()
    var choosenDate: String = "" {
        didSet {
            fetchDailyBoxOffice()
            setNavigationBarTitle()            
        }
    }
    
    @IBOutlet weak var boxOfficeListCollectionView: UICollectionView!
    lazy var activityIndicator = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchDailyBoxOffice()
        setUpView()
        setCalendarViewDelegate()
    }
    
    private func fetchDailyBoxOffice() {
        if choosenDate == "" {
            choosenDate = self.getYesterdayDescription()
        }
        
        boxOfficeService.fetchDailyBoxOfficeAPI(date: choosenDate) {
            DispatchQueue.main.async {
                self.boxOfficeListCollectionView.reloadData()
                self.activityIndicator.stopAnimating()
            }
        }
    }
    
    private func setUpView() {
        setNavigationBar()
        setActivityIndicator()
        setBoxOfficeListCollectionView()
        configureRefreshControl()
        configureUI()
        setNavigationToolBar()
    }
    
    private func setNavigationBar() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "날짜선택", style: .plain, target: self, action: #selector(tabRightBarButton))
    }
    
    @objc
    private func tabRightBarButton() {
        self.present(calendarViewController, animated: true, completion: nil)
    }
    
    private func setActivityIndicator() {
        activityIndicator = UIActivityIndicatorView()
        activityIndicator.style = UIActivityIndicatorView.Style.large
        activityIndicator.startAnimating()
        boxOfficeListCollectionView.backgroundView = activityIndicator
    }
    
    private func setBoxOfficeListCollectionView() {
        boxOfficeListCollectionView.dataSource = self
        boxOfficeListCollectionView.delegate = self
        self.boxOfficeListCollectionView.collectionViewLayout = self.setUpCompositionalListLayout()
    }
    
    private func configureRefreshControl() {
        boxOfficeListCollectionView.refreshControl = UIRefreshControl()
        boxOfficeListCollectionView.refreshControl?.addTarget(self, action:
                                                                #selector(handleRefreshControl),
                                                              for: .valueChanged)
    }
    
    @objc
    private func handleRefreshControl() {
        DispatchQueue.main.async {
            self.boxOfficeListCollectionView.reloadData()
            self.boxOfficeListCollectionView.refreshControl?.endRefreshing()
        }
    }
    
    private func configureUI() {
        let safeArea = view.safeAreaLayoutGuide
        
        boxOfficeListCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            boxOfficeListCollectionView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            boxOfficeListCollectionView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            boxOfficeListCollectionView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            boxOfficeListCollectionView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor)
        ])
    }
    
    private func setCalendarViewDelegate() {
        calendarViewController.delegate = self
    }
    
    private func setNavigationBarTitle() {
        self.title = choosenDate.insertDash()
    }
    
    private func getYesterdayDescription() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMdd"
        let yesterDate = formatter.string(from: Date(timeIntervalSinceNow: -86400))
        return yesterDate
    }
    
    private func setNavigationToolBar() {
        let flexibleSpace: UIBarButtonItem
        let changeModeButton: UIBarButtonItem
        
        changeModeButton = UIBarButtonItem(title: "화면 모드 변경", style: .plain, target: self, action: #selector(convertAlertMode))
        flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        
        toolbarItems = [flexibleSpace, changeModeButton, flexibleSpace]
        self.navigationController?.isToolbarHidden = false
    }
    
    @objc func convertAlertMode() {
        switch self.isCurrentListLayout {
        case true:
            return changeToIconAlert()
        case false:
            return changeToListAlert()
        }
    }
    
    private func changeToIconAlert() {
        let alertToIconLayout = UIAlertController(title: "화면 모드 변경", message: "", preferredStyle: .actionSheet)
        
        alertToIconLayout.addAction(UIAlertAction(title: "아이콘", style: .default, handler: { _ in
            self.boxOfficeListCollectionView.collectionViewLayout = self.setUpCompositionalIconLayout()
            self.boxOfficeListCollectionView.reloadData()
            self.isCurrentListLayout = false
        }))
        alertToIconLayout.addAction(UIAlertAction(title: "취소", style: .cancel, handler: { _ in print("알럿 취소") }))
        present(alertToIconLayout, animated: true)
    }
    
    private func changeToListAlert() {
        let alertToListLayout = UIAlertController(title: "화면 모드 변경", message: "", preferredStyle: .actionSheet)
        alertToListLayout.addAction(UIAlertAction(title: "리스트", style: .default, handler: { _ in
            self.boxOfficeListCollectionView.collectionViewLayout = self.setUpCompositionalListLayout()
            self.boxOfficeListCollectionView.reloadData()
            self.isCurrentListLayout = true
        }))
        alertToListLayout.addAction(UIAlertAction(title: "취소", style: .cancel, handler: { _ in print("알럿 취소") }))
        present(alertToListLayout, animated: true)
    }
    
    
}

extension BoxOfficeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return boxOfficeService.dailyBoxOffice?.boxOfficeResult.dailyBoxOfficeList.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellId = String(describing: BoxOfficeListCell.self)
        let cell = boxOfficeListCollectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! BoxOfficeListCell
        if isCurrentListLayout == true {
            cell.configureListCellUI()
            cell.accessories = [.disclosureIndicator()]
        } else {
            cell.configureIconCellUI()
            cell.accessories = []
        }
        
        guard let validDailyBoxOffice = boxOfficeService.dailyBoxOffice else {
            return cell
        }

        cell.setUpLabel(by: validDailyBoxOffice, indexPath: indexPath)
        return cell
    }
    
    private func convertRankGapPresentation(indexPath: IndexPath) -> NSMutableAttributedString {
        guard let rankGap = boxOfficeService.dailyBoxOffice?.boxOfficeResult.dailyBoxOfficeList[indexPath.row].rankGap,
              let rankOldAndNew = boxOfficeService.dailyBoxOffice?.boxOfficeResult.dailyBoxOfficeList[indexPath.row].rankOldAndNew,
               let intRankGap = Int(rankGap) else { return NSMutableAttributedString().makeColorToText(string: "", color: .red) }
         
         if rankOldAndNew == "NEW" {
             return NSMutableAttributedString().makeColorToText(string: "신작", color: .red)
         }
         
         switch intRankGap {
         case -20 ... -1:
             return NSMutableAttributedString().makeColorToText(string: "▼", color: .blue).makeColorToText(string: rankGap.trimmingCharacters(in: ["-"]), color: .black)
         case 1...20:
             return NSMutableAttributedString().makeColorToText(string: "▲", color: .red).makeColorToText(string: rankGap, color: .black)
         case 0:
             return NSMutableAttributedString().makeColorToText(string: "-", color: .black)
         default:
             return NSMutableAttributedString().makeColorToText(string: "", color: .black)
         }
     }
}

extension BoxOfficeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movieDetailVC = MovieDetailViewController()
        guard let movieCode = boxOfficeService.dailyBoxOffice?.boxOfficeResult.dailyBoxOfficeList[indexPath.row].movieCode else { return }
        movieDetailVC.boxOfficeService.receiveMovieCode(movieCode: movieCode)
       
        self.navigationController?.pushViewController(movieDetailVC, animated: true)
    }
}

extension BoxOfficeViewController {
    private func setUpCompositionalListLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout {
            (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            
            item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
            
            let groupHeight =  NSCollectionLayoutDimension.fractionalWidth(1/4)
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: groupHeight)
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)
            let section = NSCollectionLayoutSection(group: group)
            
            return section
        }
        return layout
    }
    
    private func setUpCompositionalIconLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout {
            (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            
            item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
            
            let groupHeight =  NSCollectionLayoutDimension.fractionalWidth(1/2.3)
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: groupHeight)
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 2)
            let section = NSCollectionLayoutSection(group: group)
            
            return section
        }
        return layout
    }
}

extension BoxOfficeViewController: CalendarDateDelegate {
    func receiveDate(date: String) {
        choosenDate = date
        print(choosenDate)
    }
}
