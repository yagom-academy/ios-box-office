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
        let viewa = CustomStackView(title: "ddd")
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
        
        contentStackView.addArrangedSubview(imageView)
        contentStackView.addArrangedSubview(infoStackView("감독", StackViewTag.director))
        contentStackView.addArrangedSubview(infoStackView("제작년도", StackViewTag.productYear))
        contentStackView.addArrangedSubview(infoStackView("개봉일", StackViewTag.openDate))
        contentStackView.addArrangedSubview(infoStackView("상영시간", StackViewTag.showTime))
        contentStackView.addArrangedSubview(infoStackView("관람등급", StackViewTag.watchGrade))
        contentStackView.addArrangedSubview(infoStackView("제작국가", StackViewTag.nation))
        contentStackView.addArrangedSubview(infoStackView("장르", StackViewTag.genres))
        contentStackView.addArrangedSubview(infoStackView("배우", StackViewTag.actors))
        
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
        
        let stackViews = contentStackView.arrangedSubviews.compactMap{ $0 as? UIStackView }
       
        stackViews.forEach { view in
            switch view.tag {
            case StackViewTag.director:
                configureContextLabel(stackView: view, context: director)
            case StackViewTag.productYear:
                configureContextLabel(stackView: view, context: productYear)
            case StackViewTag.openDate:
                configureContextLabel(stackView: view, context: openDate)
            case StackViewTag.showTime:
                configureContextLabel(stackView: view, context: showTime)
            case StackViewTag.watchGrade:
                configureContextLabel(stackView: view, context: watchGrade)
            case StackViewTag.nation:
                configureContextLabel(stackView: view, context: nation)
            case StackViewTag.genres:
                configureContextLabel(stackView: view, context: genre)
            case StackViewTag.actors:
                configureContextLabel(stackView: view, context: actor)
            default:
                return
            }
        }
    }
    
    private func configureContextLabel(stackView: UIStackView, context: String?) {
        let contextLabel = stackView.arrangedSubviews.filter{ $0.tag == LabelTag.contextLabel }
        let label = contextLabel.first as? UILabel
        label?.text = context
    }
}

enum LabelTag {
    static let titleLabel = 0
    static let contextLabel = 1
}

enum StackViewTag {
    static let director = 0
    static let productYear = 1
    static let openDate = 2
    static let showTime = 3
    static let watchGrade = 4
    static let nation = 5
    static let genres = 6
    static let actors = 7
}
