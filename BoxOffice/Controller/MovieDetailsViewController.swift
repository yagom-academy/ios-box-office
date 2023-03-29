//
//  MovieDetailsViewController.swift
//  BoxOffice
//
//  Created by Muri, Rowan on 2023/03/29.
//

import UIKit

final class MovieDetailsViewController: UIViewController {
    private let directorView = CategoryStackView()
    private let productionYearView = CategoryStackView()
    private let openDateView = CategoryStackView()
    private let runningTimeView = CategoryStackView()
    private let watchGradeView = CategoryStackView()
    private let nationView = CategoryStackView()
    private let genreView = CategoryStackView()
    private let actorView = CategoryStackView()
    private let posterView = UIImageView()
    private var scrollView = {
        let scrollView = UIScrollView()
        
        return scrollView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func configureScrollView() {
        let contentView = {
            let stackView = UIStackView()
            stackView.axis = .vertical
            stackView.alignment = .center
            stackView.translatesAutoresizingMaskIntoConstraints = false
            
            let subviews = [
                posterView, directorView, productionYearView, openDateView,
                runningTimeView, watchGradeView, nationView, genreView, actorView
            ]
            subviews.forEach {
                stackView.addArrangedSubview($0)
            }
            
            return stackView
        }()
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
        
        scrollView.addSubview(contentView)
        
        NSLayoutConstraint.activate([
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor)
        ])
        
        let heightConstraint = contentView.heightAnchor.constraint(equalTo: scrollView.frameLayoutGuide.heightAnchor)
        heightConstraint.priority = .defaultLow
    }
}
