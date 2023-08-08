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
        stackView.spacing = 5
        
        return stackView
    }()
    
    private let posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        
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
        passFetchedImage()
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
            scrollView.widthAnchor.constraint(equalTo: safeArea.widthAnchor),
            scrollView.heightAnchor.constraint(equalTo: safeArea.heightAnchor),
            scrollView.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            scrollView.centerYAnchor.constraint(equalTo: safeArea.centerYAnchor),
            
            mainStackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            mainStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            mainStackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -10),
            mainStackView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            
            posterImageView.widthAnchor.constraint(equalTo: mainStackView.widthAnchor, multiplier: 0.95),
            posterImageView.heightAnchor.constraint(equalTo: posterImageView.widthAnchor, multiplier: 1.5),
            directorsStackView.widthAnchor.constraint(equalTo: mainStackView.widthAnchor),
            productionYearStackView.widthAnchor.constraint(equalTo: mainStackView.widthAnchor),
            openingDateStackView.widthAnchor.constraint(equalTo: mainStackView.widthAnchor),
            showTimeStackView.widthAnchor.constraint(equalTo: mainStackView.widthAnchor),
            auditsStackView.widthAnchor.constraint(equalTo: mainStackView.widthAnchor),
            nationsStackView.widthAnchor.constraint(equalTo: mainStackView.widthAnchor),
            genresStackView.widthAnchor.constraint(equalTo: mainStackView.widthAnchor),
            actorsStackView.widthAnchor.constraint(equalTo: mainStackView.widthAnchor)
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
    
    private func passFetchedImage() {
        var urlComponents = URLComponents(string: NetworkNamespace.daumImage.url)
        urlComponents?.queryItems = [URLQueryItem(name: "query", value: "\(movieName) 영화 포스터")]
        
        guard let url = urlComponents?.url else {
            return
        }
        
        var request = URLRequest(url: url)
        
        request.setValue("KakaoAK \(NetworkNamespace.daumApiKey)", forHTTPHeaderField: "Authorization")
        
        networkingManager?.load(request) { [weak self] (result: Result<Data, NetworkingError>) in
            switch result {
            case .success(let data):
                do {
                    let decodedData: DaumImageEntity = try DecodingManager.shared.decode(data)
                    
                    guard let firstData = decodedData.documents.first,
                          let imageUrl = URL(string: firstData.imageURL),
                          let image = try? Data(contentsOf: imageUrl) else {
                        return
                    }
                    
                    DispatchQueue.main.async {
                        self?.posterImageView.image = UIImage(data: image)
                    }
                } catch {
                    print(DecodingError.decodingFailure.description)
                }
            case .failure(let error):
                print(error.description)
            }
        }
    }
    
    private func setUpLabelText(_ data: MovieDetailEntity) {
        directorsStackView.valueLabel.text = data.movieDetailData.movieInformation.directors.reduce("") { $0 + $1.name + ", " }
        productionYearStackView.valueLabel.text = data.movieDetailData.movieInformation.productionYear
        openingDateStackView.valueLabel.text = data.movieDetailData.movieInformation.openingDate
        showTimeStackView.valueLabel.text = data.movieDetailData.movieInformation.showTime
        auditsStackView.valueLabel.text = data.movieDetailData.movieInformation.audits.reduce("") { $0 + $1.movieRating + ", " }
        nationsStackView.valueLabel.text = data.movieDetailData.movieInformation.nations.reduce("") { $0 + $1.name + ", " }
        genresStackView.valueLabel.text = data.movieDetailData.movieInformation.genres.reduce("") { $0 + $1.name + ", " }
        actorsStackView.valueLabel.text = data.movieDetailData.movieInformation.actors.reduce("") { $0 + $1.name + ", " }

    }
}
