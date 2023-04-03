//
//  DetailMovieViewController.swift
//  BoxOffice
//
//  Created by Rhode, Rilla on 2023/03/31.
//

import UIKit

final class DetailMovieViewController: UIViewController {
    // MARK: - Property
    private let server = NetworkManager()
    private let urlMaker = URLRequestMaker()
    private var movieCode: String
    private var movieInformation: MovieInformation? {
        didSet {
            DispatchQueue.main.async {
                self.configureMainView()
            }
        }
    }
    private var moviePoster: MoviePoster?
    
    private let scrollView: UIScrollView = {
        let scrollview = UIScrollView()
        scrollview.translatesAutoresizingMaskIntoConstraints = false
        
        return scrollview
    }()
    
    private let contentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 15
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    private let imageView = UIImageView()

    // MARK: - Method
    init(movieCode: String) {
        self.movieCode = movieCode
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewController()
    }
    
    private func fetchData() {
        fetchMovieInformationData(movieCode: movieCode) {
            guard let movieName = self.movieInformation?.movieName else { return }

            self.fetchMoviePosterData(movieName: movieName) {
                guard let urlString = self.moviePoster?.documents[0].imageURL else { return }
                
                CacheManager.loadImage(imageURL: urlString) { image in
                    DispatchQueue.main.async {
                        LoadingIndicator.hideLoading()
                        self.imageView.image = image
                    }
                }
            }
        }
    }
    
    private func fetchMovieInformationData(movieCode: String, completion: @escaping () -> Void) {
        guard let request = urlMaker.makeMovieInformationURLRequest(movieCode: movieCode) else { return }
        
        server.startLoad(request: request, mime: "json") { result in
            let decoder = DecodeManager()
            do {
                guard let verifiedFetchingResult = try self.verifyResult(result: result) else { return }
                let decodedFile = decoder.decodeJSON(data: verifiedFetchingResult, type: DetailMovieInformation.self)
                let verifiedDecodingResult = try self.verifyResult(result: decodedFile)
                
                self.movieInformation = verifiedDecodingResult?.movieInformationResult.movieInformation
                completion()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    private func fetchMoviePosterData(movieName: String, completionHandler: @escaping () -> Void) {
        guard let posterRequest = urlMaker.makeMoviePosterURLRequest(movieName: movieName) else { return }
        server.startLoad(request: posterRequest, mime: "json") { result in
            let decoder = DecodeManager()
            do {
                guard let verifiedFetchingResult = try self.verifyResult(result: result) else { return }
                let decodedFile = decoder.decodeJSON(data: verifiedFetchingResult, type: MoviePoster.self)
                let verifiedDecodingResult = try self.verifyResult(result: decodedFile)
                
                self.moviePoster = verifiedDecodingResult
                completionHandler()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    private func verifyResult<T, E: Error>(result: Result<T, E>) throws -> T? {
        switch result {
        case .success(let data):
            return data
        case .failure(let error):
            throw error
        }
    }
    
    private func configureViewController() {
        view.backgroundColor = .white
        LoadingIndicator.showLoading()
        fetchData()
    }
    
    private func configureMainView() {
        
        title = movieInformation?.movieName
        
        configureScrollView()
        configureStackView()
        configureContentStackView()
        configureImageView()
    }
    
    private func configureImageView() {
        imageView.contentMode = .scaleAspectFit
        
        NSLayoutConstraint.activate([
            imageView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.6)
        ])
        
    }

    private func configureScrollView() {
        view.addSubview(scrollView)
        
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    private func configureContentStackView() {
        let director = convertString(items: movieInformation?.directors ?? [])
        let watchGrade = convertString(items: movieInformation?.audits ?? [])
        let nation = convertString(items: movieInformation?.nations ?? [])
        let genre = convertString(items: movieInformation?.genres ?? [])
        let actor = convertString(items: movieInformation?.actors ?? [])
        let productYear = movieInformation?.productYear
        let openDate = movieInformation?.openDate.formatDateString()
        let showTime = movieInformation?.showTime
        
        let directorStackView = makeInfoStackView(title: "감독", context: director)
        let productYearStackView = makeInfoStackView(title: "제작년도", context: productYear)
        let openDateStackView = makeInfoStackView(title: "개봉일", context: openDate)
        let showTimeStackView = makeInfoStackView(title: "상영시간", context: showTime)
        let watchGradeStackView = makeInfoStackView(title: "관람등급", context: watchGrade)
        let nationStackView = makeInfoStackView(title: "제작국가", context: nation)
        let genresStackView = makeInfoStackView(title: "장르", context: genre)
        let actorsStackView = makeInfoStackView(title: "배우", context: actor)
        
        contentStackView.addArrangedSubview(imageView)
        contentStackView.addArrangedSubview(directorStackView)
        contentStackView.addArrangedSubview(productYearStackView)
        contentStackView.addArrangedSubview(openDateStackView)
        contentStackView.addArrangedSubview(showTimeStackView)
        contentStackView.addArrangedSubview(watchGradeStackView)
        contentStackView.addArrangedSubview(nationStackView)
        contentStackView.addArrangedSubview(genresStackView)
        contentStackView.addArrangedSubview(actorsStackView)
    }
    
    private func configureStackView() {
        scrollView.addSubview(contentStackView)
        
        NSLayoutConstraint.activate([
            contentStackView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            contentStackView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            contentStackView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            contentStackView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            contentStackView.leadingAnchor.constraint(equalTo: scrollView.frameLayoutGuide.leadingAnchor),
            contentStackView.trailingAnchor.constraint(equalTo: scrollView.frameLayoutGuide.trailingAnchor),
        ])
    }
    
    private func makeInfoStackView(title: String, context: String?) -> UIStackView  {
        let titleLabel: UILabel = {
            let label = UILabel()
            label.text = title
            label.font = .boldSystemFont(ofSize: 17)
            label.textAlignment = .center
            
            return label
        }()
        
        let contextLabel: UILabel = {
            let label = UILabel()
            label.text = context
            label.font = .systemFont(ofSize: 17)
            label.textAlignment = .left
            label.numberOfLines = 0
            
            return label
        }()
        
        let stackView: UIStackView = {
            let stackView = UIStackView(arrangedSubviews: [titleLabel, contextLabel])
            stackView.axis = .horizontal
            stackView.alignment = .fill
            stackView.distribution = .fill
            stackView.spacing = 10
            
            return stackView
        }()
        
        NSLayoutConstraint.activate([
            titleLabel.widthAnchor.constraint(equalTo: stackView.widthAnchor, multiplier: 0.17),
        ])
        
        return stackView
    }
    
    private func convertString(items: [StringConvertible]) -> String {
        guard items.isEmpty == false else { return "-"}
        
        var resultString = ""
        items.forEach { item in
            if resultString.isEmpty {
                resultString = item.description
            } else {
                resultString +=  ", \(item.description)"
            }
        }
        return resultString
    }
}
