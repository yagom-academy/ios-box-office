//
//  MovieDetailViewController.swift
//  BoxOffice
//
//  Created by Yetti, Maxhyunm on 2023/08/08.
//

import UIKit

final class MovieDetailViewController: UIViewController {
    private var networkingManager: NetworkingManager?
    private let movieCode: String
    private let movieName: String
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        return scrollView
    }()
    
    private let mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .center
        
        return stackView
    }()
    
    private let posterImageView: UIImageView = {
        let imageView = UIImageView()
        
        return imageView
    }()
    
    private let directorsStackView = MovieDetailStackView(title: "감독")
    private let productionYearStackView = MovieDetailStackView(title: "제작년도")
    private let openingDateStackView = MovieDetailStackView(title: "개봉일")
    private let showTimeStackView = MovieDetailStackView(title: "상영시간")
    private let auditsStackView = MovieDetailStackView(title: "관람등급")
    private let nationsStackView = MovieDetailStackView(title: "제작국가")
    private let genresStackView = MovieDetailStackView(title: "장르")
    private let actorsStackView = MovieDetailStackView(title: "배우")
    
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
        addViews()
        setUpUI()
        setUpNetwork()
        passFetchedData()
    }
    
    private func addViews() {
        view.addSubview(scrollView)
        scrollView.addSubview(mainStackView)
        mainStackView.addArrangedSubview(posterImageView)
        mainStackView.addArrangedSubview(directorsStackView)
        mainStackView.addArrangedSubview(productionYearStackView)
        mainStackView.addArrangedSubview(openingDateStackView)
        mainStackView.addArrangedSubview(showTimeStackView)
        mainStackView.addArrangedSubview(auditsStackView)
        mainStackView.addArrangedSubview(nationsStackView)
        mainStackView.addArrangedSubview(genresStackView)
        mainStackView.addArrangedSubview(actorsStackView)
    }
    
    private func setUpUI() {
        self.title = movieName
        let safeArea = view.safeAreaLayoutGuide
        view.backgroundColor = .systemBackground

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            
            mainStackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            mainStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            mainStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            mainStackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor)
        ])
    }
}

extension MovieDetailViewController: URLSessionDelegate {
    private func setUpNetwork() {
        let session: URLSession = {
            let configuration = URLSessionConfiguration.default
            configuration.waitsForConnectivity = true
            
            return URLSession(configuration: configuration, delegate: self, delegateQueue: nil)
        }()
        
        networkingManager = NetworkingManager(session)
    }
    
    private func passFetchedData() {
        guard let url = URL(string: String(format: NetworkNamespace.movieDetail.url, NetworkNamespace.apiKey, movieCode))
        else {
            return
        }
        
        let request = URLRequest(url: url)
        
        networkingManager?.load(request) { [weak self] (result: Result<Data, NetworkingError>) in
            switch result {
            case .success(let data):
                do {
                    let decodedData: MovieDetailEntity = try DecodingManager.shared.decode(data)
                    
                    DispatchQueue.main.async {
                        self?.setUpLabelText(decodedData)
                    }
                } catch {
                    print(DecodingError.decodingFailure.description)
                }
            case .failure(let error):
                print(error.description)
            }
            
//            DispatchQueue.main.async {
//                self?.isLoading = false
//                self?.refreshControl.endRefreshing()
//            }
        }
    }
    
    private func setUpLabelText(_ data: MovieDetailEntity) {
        directorsStackView.valueLabel.text = data.movieDetailData.movieInformation.directors.reduce("") { $0 + $1.name + "," }
    }
}
