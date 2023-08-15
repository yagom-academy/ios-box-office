//
//  ViewController.swift
//  BoxOffice
//
//  Created by redmango, Jusbug on 13/01/23.
//

import UIKit

final class MainViewController: UIViewController, CalendarViewControllerDelegate {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var loadingActivityView: UIActivityIndicatorView!
    @IBOutlet weak var calendarButton: UIButton!
    @IBOutlet weak var changeModeButton: UIButton!
    var boxOffice: BoxOffice?
    var isIconMode = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showLodingView()
        assignDataSourceAndDelegate()
        registerCustomCell()
        callAPIManager()
        configureTitle()
        initRefresh()
    }
    
    @IBAction func tapChangeModeButton(_ sender: Any) {
        let actionSheet = UIAlertController(title: "화면모드변경", message: nil, preferredStyle: .actionSheet)
        
        let icon = UIAlertAction(title: "아이콘", style: .default) { action in
            print("Selected icon")
            self.isIconMode = true
            self.collectionView.reloadData()
        }
        
        let list = UIAlertAction(title: "리스트", style: .default) { action in
            print("Selected list")
            self.isIconMode = false
            self.collectionView.reloadData()
        }
        
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        
        if isIconMode {
            actionSheet.addAction(list)
        } else {
            actionSheet.addAction(icon)
        }
        
        actionSheet.addAction(cancel)
        
        present(actionSheet, animated: true, completion: nil)
    }
    
    private func showLodingView() {
        collectionView.isHidden = true
        loadingActivityView.startAnimating()
    }
    
    private func hideLoadingView() {
        self.collectionView.isHidden = false
        self.loadingActivityView.isHidden = true
        self.loadingActivityView.stopAnimating()
    }
    
    private func assignDataSourceAndDelegate() {
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    @IBAction func tabCalendarButton(_ sender: UIButton) {
        let calendarVC = CalendarViewController(selectedDate: URLManager.shared.selectedDate, delegate: self)
        calendarVC.modalPresentationStyle = .popover
        self.present(calendarVC, animated: true, completion: nil)
    }
    
    private func initRefresh() {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(updateData), for: .valueChanged)
        refreshControl.backgroundColor = UIColor.clear
        refreshControl.attributedTitle = NSAttributedString(string: "Loading...", attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemGray, NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 20)])
        self.collectionView.refreshControl = refreshControl
    }
    
    private func configureTitle() {
        guard let yesterday = DateProvider().updateDate(to: -1, by: .viewTitle) else {
            return
        }
        
        self.navigationItem.title = "\(yesterday)"
    }
    
    func didSelectDate(_ date: Date) {
        URLManager.shared.selectedDate = date
        let dateString = DateProvider().formatDate(with: date, by: .viewTitle)
        self.navigationItem.title = "\(dateString)"
        self.callAPIManager()
    }
    
    private func registerCustomCell() {
        collectionView.register(UINib(nibName: "CollectionViewListCell", bundle: nil),
                                forCellWithReuseIdentifier: "listCell")
        collectionView.register(UINib(nibName: "CollectionViewIconCell", bundle: nil),
                                forCellWithReuseIdentifier: "iconCell")
    }
    
    @objc private func updateData() {
        callAPIManager()
        NotificationCenter.default.addObserver(self, selector: #selector(reloadCollectionView), name: Notification.Name("completed"), object: nil)
    }
    
    @objc private func reloadCollectionView() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
            self.collectionView.refreshControl?.endRefreshing()
            self.hideLoadingView()
        }
    }
    
    private func callAPIManager() {
        APIManager().fetchData(service: .dailyBoxOffice) { result in
            let jsonDecoder = JSONDecoder()
            switch result {
            case .success(let data):
                if let decodedData: BoxOffice = jsonDecoder.decodeJSON(data: data) {
                    self.boxOffice = decodedData
                    DispatchQueue.main.async {
                        self.collectionView.reloadData()
                        self.hideLoadingView()
                    }
                } else {
                    print("Decoding Error")
                }
            case .failure(let error):
                print(error)
            }
            
            NotificationCenter.default.post(name: Notification.Name("completed"), object: nil)
        }
    }
}

extension MainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return boxOffice?.boxOfficeResult.dailyBoxOfficeList.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if isIconMode {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "iconCell", for: indexPath) as? CollectionViewIconCell else { return UICollectionViewCell() }
            
            if let boxOfficeData = boxOffice {
                let dailyBoxOffice = boxOfficeData.boxOfficeResult.dailyBoxOfficeList[indexPath.item]
                cell.configureLabels(with: dailyBoxOffice)
                cell.configureFont()
                cell.configureDynamicType()
            }
            
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "listCell", for: indexPath) as? CollectionViewListCell else { return UICollectionViewListCell() }
            
            if let boxOfficeData = boxOffice {
                let dailyBoxOffice = boxOfficeData.boxOfficeResult.dailyBoxOfficeList[indexPath.item]
                cell.configureLabels(with: dailyBoxOffice)
                cell.configureFont()
                cell.configureDynamicType()
                cell.accessories = [.disclosureIndicator()]
            }
            
            return cell
        }
    }
}

extension MainViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let pushMovieDetailVC = self.storyboard?.instantiateViewController(withIdentifier: "MovieDetailViewController") else { return }
        
        self.navigationController?.pushViewController(pushMovieDetailVC, animated: true)
    }
}

extension MainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let viewWidth = collectionView.bounds.width
        let viewHeight = collectionView.bounds.height
        
        if isIconMode {
            let cellWidth = (viewWidth - 20 * 3) / 2
            return CGSize(width: cellWidth, height: cellWidth)
        } else {
            return CGSize(width: viewWidth, height: viewHeight / 9)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if isIconMode {
            return UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        } else {
            return UIEdgeInsets.zero
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if isIconMode {
            return 10
        } else {
            return 1
        }
    }
}
