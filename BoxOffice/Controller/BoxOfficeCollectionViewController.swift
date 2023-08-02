//
//  BoxOfficeCollectionView.swift
//  BoxOffice
//
//  Created by EtialMoon, Minsup on 2023/07/31.
//

import SwiftUI

class BoxOfficeCollectionViewController: UICollectionViewController {
    let navigationBarDateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd"
        return dateFormatter
    }()
    let boxOfficeDateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYYMMdd"
        return dateFormatter
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
        configureCompositionalLayout()
        navigationItem.title = getYesterday(dateFormatter: navigationBarDateFormatter)
    }
    
    private func registerCell() {
        collectionView.register(BoxOfficeCollectionViewCell.self, forCellWithReuseIdentifier: BoxOfficeCollectionViewCell.identifier)
    }
    
    private func configureCompositionalLayout() {
        let config = UICollectionLayoutListConfiguration(appearance: .plain)
        let layout = UICollectionViewCompositionalLayout.list(using: config)
        
        collectionView.collectionViewLayout = layout
    }
    
    func getYesterday(dateFormatter: DateFormatter) -> String {
        let today = Date()
        let todayYear = Calendar.current.dateComponents([.year], from: today)
        let todayMonth = Calendar.current.dateComponents([.month], from: today)
        let todayDay = Calendar.current.dateComponents([.day], from: today)
        
        guard let year = todayYear.year,
              let month = todayMonth.month,
              let day = todayDay.day else {
            return "날짜를 알 수 없습니다."
        }
        
        let yesterdayComponents = DateComponents(year: year, month: month, day: day - 1)
        guard let yesterday = Calendar.current.date(from: yesterdayComponents) else {
            return "날짜를 알 수 없습니다."
        }
        
        return dateFormatter.string(from: yesterday)
    }
}

// MARK: - DataSource
extension BoxOfficeCollectionViewController {
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BoxOfficeCollectionViewCell.identifier, for: indexPath) as! BoxOfficeCollectionViewCell
        
        cell.configureCell()
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
}

// MARK: - Preview
struct BoxOfficeCollectionViewPreview: PreviewProvider {
    static var previews: some View {
        BoxOfficeCollectionViewController().toPreview()
    }
}
