//
//  MovieDetailViewController.swift
//  BoxOffice
//
//  Created by vetto, brody on 2023/03/31.
//

import UIKit

final class MovieDetailViewController: UIViewController {
    let movieName: String
    let movieCode: String
    private var movieDetailInformation: MovieDetailInformationItem? {
        didSet {
            guard let information = movieDetailInformation else {
                return
            }
            movieInformationStackView.setupInformation(information: information)
        }
    }
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()

    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 10
        return stackView
    }()
    
    private let posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let movieInformationStackView = MovieInformationStackView(frame: .zero)
    
    init(movieName: String, movieCode: String) {
        self.movieName = movieName
        self.movieCode = movieCode
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        setupUI()
        fetchMovieDetail()
        fetchMoviePoster()
    }
    
    private func setupUI() {
        self.navigationItem.title = movieName
        view.backgroundColor = .white
        self.view.addSubview(self.scrollView)
        self.scrollView.addSubview(self.stackView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            
            stackView.topAnchor.constraint(equalTo: self.scrollView.contentLayoutGuide.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: self.scrollView.contentLayoutGuide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: self.scrollView.contentLayoutGuide.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: self.scrollView.contentLayoutGuide.bottomAnchor),
            stackView.widthAnchor.constraint(equalTo: self.scrollView.widthAnchor)
        ])
    
        stackView.addArrangedSubview(posterImageView)
        stackView.addArrangedSubview(movieInformationStackView)
    }
    
    private func fetchMovieDetail() {
        let boxOfficeProvider = BoxOfficeProvider<BoxOfficeAPI>()
        boxOfficeProvider.fetchData(.detailMovieInformation(movieCode: self.movieCode),
                                    type: MovieInformationDTO.self) { [weak self] result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    self?.movieDetailInformation = data.toDomain()
                }
            case .failure:
                print("실패")
            }
        }
    }
    
    private func fetchMoviePoster() {
        let boxOfficeProvider = BoxOfficeProvider<DaumAPI>()
        boxOfficeProvider.fetchData(.searchImage(movieName: "\(self.movieName) 영화 포스터"),
                                    type: SearchedMovieImageDTO.self) { [weak self] result in
            switch result {
            case .success(let data):
                guard let url = data.documents.first?.imageURL,
                      let imageUrl = URL(string: url) else {
                    return
                }
                guard let image = try? Data(contentsOf: imageUrl) else { return }
                DispatchQueue.main.async {
                    self?.posterImageView.image = UIImage(data: image)
                }
            case .failure:
                print("실패")
            }
        }
    }
}


