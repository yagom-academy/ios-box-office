//
//  DetailMovieViewController.swift
//  BoxOffice
//
//  Created by Rhode, Rilla on 2023/03/31.
//

import UIKit

final class DetailMovieViewController: UIViewController {
    // MARK: - Property
    private let server = NetworkManager.shared
    private let urlMaker = URLRequestMaker()
    private var movieCode: String
    private var movieInformation: MovieInformation? {
        didSet {
            DispatchQueue.main.async {
                self.configureContentStackView()
            }
        }
    }
    private var moviePoster: MoviePoster?
    
    //MARK: - UIProperty
    private let scrollView: UIScrollView = {
        let scrollview = UIScrollView()
        scrollview.translatesAutoresizingMaskIntoConstraints = false
        
        return scrollview
    }()
    
    private let contentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 15
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    private let directorStackView = CustomStackView(title: "감독")
    private let productYearStackView = CustomStackView(title: "제작년도")
    private let openDateStackView = CustomStackView(title: "개봉일")
    private let showTimeStackView = CustomStackView(title: "상영시간")
    private let watchGradeStackView = CustomStackView(title: "관람등급")
    private let nationStackView = CustomStackView(title: "제작국가")
    private let genresStackView = CustomStackView(title: "장르")
    private let actorsStackView = CustomStackView(title: "배우")
    
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
        fetchMovieInformationData(movieCode: movieCode) { [weak self] in
            guard let movieName = self?.movieInformation?.movieName else { return }

            self?.fetchMoviePosterData(movieName: movieName) {
                guard let urlString = self?.moviePoster?.documents[0].imageURL else { return }
                
                ImageLoader.loadImage(imageURL: urlString) { result in
                    DispatchQueue.main.async {
                        LoadingIndicator.hideLoading()
                        self?.imageView.image = try? self?.verifyResult(result: result)
                        self?.configureContentStackView()
                    }
                }
            }
        }
    }
    
    private func fetchMovieInformationData(movieCode: String, completion: @escaping () -> Void) {
        guard let request = urlMaker.makeMovieInformationURLRequest(movieCode: movieCode) else { return }
        
        server.startLoad(request: request, mime: "json") { [weak self] result in
            let decoder = DecodeManager()
            
            guard let verifiedFetchingResult = try? self?.verifyResult(result: result) else { return }
            let decodedFile = decoder.decodeJSON(data: verifiedFetchingResult, type: DetailMovieInformation.self)
            let verifiedDecodingResult = try? self?.verifyResult(result: decodedFile)
            
            self?.movieInformation = verifiedDecodingResult?.movieInformationResult.movieInformation
            completion()
        }
    }
    
    private func fetchMoviePosterData(movieName: String, completion: @escaping () -> Void) {
        guard let posterRequest = urlMaker.makeMoviePosterURLRequest(movieName: movieName) else { return }
        
        server.startLoad(request: posterRequest, mime: "json") { [weak self] result in
            let decoder = DecodeManager()
            
            guard let verifiedFetchingResult = try? self?.verifyResult(result: result) else { return }
            let decodedFile = decoder.decodeJSON(data: verifiedFetchingResult, type: MoviePoster.self)
            let verifiedDecodingResult = try? self?.verifyResult(result: decodedFile)
            
            self?.moviePoster = verifiedDecodingResult
            completion()
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
        configureMainView()
    }
    
    private func configureMainView() {
        title = movieInformation?.movieName
        configureUI()
        configureLayout()
    }
    
    private func configureUI() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentStackView)
        
        [imageView, directorStackView, productYearStackView,
         openDateStackView, showTimeStackView, watchGradeStackView,
         nationStackView, genresStackView, actorsStackView].forEach { view in
            contentStackView.addArrangedSubview(view)
        }
    }

    private func configureLayout() {
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            contentStackView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            contentStackView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            contentStackView.leadingAnchor.constraint(equalTo: scrollView.frameLayoutGuide.leadingAnchor),
            contentStackView.trailingAnchor.constraint(equalTo: scrollView.frameLayoutGuide.trailingAnchor),
            
            imageView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.6)
        ])
    }
    
    private func configureContentStackView() {
        let director = movieInformation?.directors.map(\.peopleName).joined(separator: ", ").formatEmptyString()
        let watchGrade = movieInformation?.audits.map(\.watchGradeName).joined(separator: ", ").formatEmptyString()
        let nation = movieInformation?.nations.map(\.nationName).joined(separator: ", ").formatEmptyString()
        let genre = movieInformation?.genres.map(\.genreName).joined(separator: ", ").formatEmptyString()
        let actor = movieInformation?.actors.map(\.peopleName).joined(separator: ", ").formatEmptyString()
        let productYear = movieInformation?.productYear
        let openDate = movieInformation?.openDate.formatDateString(format: DateFormat.yearMonthDay)
        let showTime = movieInformation?.showTime
        
        directorStackView.configureContext(context: director)
        productYearStackView.configureContext(context: productYear)
        openDateStackView.configureContext(context: openDate)
        showTimeStackView.configureContext(context: showTime)
        watchGradeStackView.configureContext(context: watchGrade)
        nationStackView.configureContext(context: nation)
        genresStackView.configureContext(context: genre)
        actorsStackView.configureContext(context: actor)
    }
}
