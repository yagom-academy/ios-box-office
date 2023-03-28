//
//  BoxOfficeViewController.swift
//  BoxOffice
//
//  Created by Christy, Hyemory on 2023/03/20.
//

import UIKit

class BoxOfficeViewController: UIViewController {
    var collectionView: UICollectionView!
    private let yesterday = Date().addingTimeInterval(3600 * -24)
    
    private lazy var yesterdayLabel: UILabel = {
        let label = UILabel()
        let date = yesterday.applyHyphenDate()
        
        label.text = date
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        view.addSubview(yesterdayLabel)
        yesterdayLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        yesterdayLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
}
