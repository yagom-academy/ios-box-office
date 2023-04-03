//
//  MovieDetailViewController.swift
//  BoxOffice
//
//  Created by Andrew, 레옹아범 on 2023/04/03.
//

import UIKit

final class MovieDetailViewController: UIViewController {
    
    var movieName: String = ""
    
    private let scrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
    
        return scrollView
    }()
    
    private let posterImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    private let descStackView = DescStackView()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    private func configureUI() {
        view.backgroundColor = .systemBackground
        navigationItem.title = movieName
        
        view.addSubview(scrollView)
        scrollView.addSubview(posterImageView)
        scrollView.addSubview(descStackView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            scrollView.contentLayoutGuide.widthAnchor.constraint(equalTo: view.widthAnchor),
            
            posterImageView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            posterImageView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 10),
            posterImageView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -10),
            
            descStackView.topAnchor.constraint(equalTo: posterImageView.bottomAnchor),
            descStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 5),
            descStackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -5),
            descStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
        ])
    }
    
}
