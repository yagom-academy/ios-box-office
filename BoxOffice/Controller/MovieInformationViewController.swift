//
//  MovieInformationViewController.swift
//  BoxOffice
//
//  Created by Idinaloq, MARY on 2023/08/08.
//

import UIKit

final class MovieInformationViewController: UIViewController {
    var dailyBoxOfficeData: DailyBoxOffice

    let scrollView: UIScrollView = {
        let scrollView: MovieInformationScrollView = MovieInformationScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        return scrollView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationItem()
        configureView()
        setUpAutolayout()
    }
    
    init(data: DailyBoxOffice) {
        self.dailyBoxOfficeData = data
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureNavigationItem() {
        navigationItem.title = dailyBoxOfficeData.movieName
    }
    
    private func configureView() {
        view.backgroundColor = .systemBackground
        view.addSubview(scrollView)
    }
    
    private func setUpAutolayout() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
