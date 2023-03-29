//
//  MovieInformationViewController.swift
//  BoxOffice
//
//  Created by 리지, kokkilE on 2023/03/29.
//

import UIKit

final class MovieInformationViewController: UIViewController {
    var movieInformationStackView = MovieInformationStackView(frame: .zero)
    var movieName: String?
    var movieCode: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        self.title = movieName
        view.addSubview(movieInformationStackView)
        configureContentView()
        
    }
    
    private func configureContentView() {
        movieInformationStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            movieInformationStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            movieInformationStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            movieInformationStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            movieInformationStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
}
