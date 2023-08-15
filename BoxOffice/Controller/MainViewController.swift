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
    var boxOffice: BoxOffice?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showLodingView()
        assignDataSourceAndDelegate()
        registerCustomCell()
        callAPIManager()
        configureTitle()
        initRefresh()
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
                                forCellWithReuseIdentifier: "cell")
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
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? CollectionViewListCell else { return UICollectionViewListCell() }
        
        if let boxOfficeData = boxOffice {
            let dailyBoxOffice = boxOfficeData.boxOfficeResult.dailyBoxOfficeList[indexPath.item]
            cell.configureLabels(with: dailyBoxOffice)
            cell.configureFont()
            cell.accessories = [.disclosureIndicator()]
        }
        
        return cell
    }
}

extension MainViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        guard let pushMovieDetailVC = self.storyboard?.instantiateViewController(withIdentifier: "MovieDetailViewController") else { return }
        
        self.navigationController?.pushViewController(pushMovieDetailVC, animated: true)
    }
}
