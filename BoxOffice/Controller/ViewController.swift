//
//  ViewController.swift
//  BoxOffice
//
//  Created by kjs on 13/01/23.
//

import UIKit

class BoxOfficeViewController: UIViewController {
    //var boxOfficeData: [String: BoxOffice] = [:]
    var boxOfficeData: BoxOffice?
    weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationInit()
        tableView.dataSource = self
        tableView.delegate = self
        
        let target: [QueryItemName: String] = [.targetDt: "20231215"]
        
        APIClient().fetchData(serviceType: .dailyBoxOffice, queryItem: target)
        { (result: Result<BoxOffice, Error>) in
            switch result {
            case .success(let boxOffice):
                self.boxOfficeData = boxOffice
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func navigationInit() {
        let yesterday = Date().yesterday
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        self.view.backgroundColor = .white
        self.navigationItem.title = formatter.string(from: yesterday)
        
        let button = UIButton()
    }
}

extension BoxOfficeViewController: UITableViewDataSource {
    //섹션 한개로 때리면 될거같고
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //당일 데이터의 개수
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}

extension BoxOfficeViewController: UITableViewDelegate {
}
