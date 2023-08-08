//
//  MovieDetailViewController.swift
//  BoxOffice
//
//  Created by Yetti, Maxhyunm on 2023/08/08.
//

import UIKit

final class MovieDetailViewController: UIViewController {
    private let movieCode: String
    private let movieName: String
    
    init(movieCode: String, movieName: String) {
        self.movieCode = movieCode
        self.movieName = movieName
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(movieCode)
        print(movieName)
    }
}
