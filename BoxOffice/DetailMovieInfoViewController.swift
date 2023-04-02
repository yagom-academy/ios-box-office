//
//  DetailMovieInfoViewController.swift
//  BoxOffice
//
//  Created by Seoyeon Hong on 2023/03/31.
//

import UIKit

final class DetailMovieInfoViewController: UIViewController {
    
    enum MovieInfoTitle {
        static let director = "감독"
        static let productionYear = "제작년도"
        static let openDate = "개봉일"
        static let showTime = "상영시간"
        static let watchGradeName = "관람등급"
        static let nationName = "제작국가"
        static let genreName = "장르"
        static let actorName = "배우"
    }
    
    private let movieCode: String
    private let movieName: String
    private let provider = APIProvider.shared
    
    private let mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 5
        return stackView
    }()
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private var indicatorView: UIActivityIndicatorView = {
        let indicatorView = UIActivityIndicatorView(style: .large)
        indicatorView.color = .systemRed
        indicatorView.isHidden = true
        indicatorView.translatesAutoresizingMaskIntoConstraints = false
        return indicatorView
    }()
    
    init(movieCode: String, movieName: String) {
        self.movieCode = movieCode
        self.movieName = movieName
        super.init(nibName: nil, bundle: nil)
        title = movieName
        view.backgroundColor = .white
        fetchMovieDetailData()
        fetchImageForMovie(movieName: movieName)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func fetchMovieDetailData() {
        provider.performRequest(api: .detail(code: movieCode)) { [weak self] requestResult in
            guard let self else { return }
            switch requestResult {
            case .success(let data):
                do {
                    let movieInfo: MovieInfoItem = try JSONConverter.shared.decodeData(data, T: MovieInfoItem.self)
                    let movieInfoItem = movieInfo.movieInfoResult.movieInfo
                    DEBUG_LOG(movieInfo)
                    DispatchQueue.main.async {
                        self.updateStackView(movieInfoItem)
                    }
                } catch let error as NetworkError {
                    DEBUG_LOG(error.description)
                } catch {
                    DEBUG_LOG("Unexpected error: \(error)")
                }
            case .failure(let error):
                DEBUG_LOG(error)
            }
        }
    }
    
    private func fetchImageForMovie(movieName: String) {
        let query = ImageAPI.imageQuery(movieName)
        let imageAPI = ImageAPI.imageSearchQuery(query: query)
        indicatorView.isHidden = false
        indicatorView.startAnimating()
        
        provider.performImageRequest(api: imageAPI, completionHandler: { [weak self] requestResult in
            guard let self = self else { return }
            switch requestResult {
            case .success(let data):
                do {
                    let imageSearchResult: ImageSearchResult = try JSONConverter.shared.decodeData(data, T: ImageSearchResult.self)
                    let imageInfo = imageSearchResult.documents.first
                    
                    DispatchQueue.main.async {
                        if let imageInfo = imageInfo, let url = URL(string: imageInfo.imageUrl) {
                            self.imageView.load(url: url, originalWidth: imageInfo.width)
                            self.stopIndicator()
                        }
                    }
                } catch {
                    self.stopIndicator()
                    DEBUG_LOG("Unexpected error: \(error)")
                }
                
            case .failure(let error):
                self.stopIndicator()
                DEBUG_LOG(error)
            }
        })
    }
    
    private func updateStackView(_ item: MovieInfo) {
        mainStackView.arrangedSubviews.forEach { mainStackView.removeArrangedSubview($0) }
        
        let labels = [
            MovieInfoView(title: MovieInfoTitle.director, content: item.directors.map { $0.peopleName }.joinedString),
            MovieInfoView(title: MovieInfoTitle.productionYear, content: item.productionYear),
            MovieInfoView(title: MovieInfoTitle.openDate, content: formatDate(item.openDate)),
            MovieInfoView(title: MovieInfoTitle.showTime, content: item.showTime),
            MovieInfoView(title: MovieInfoTitle.watchGradeName, content: item.audits.map { $0.watchGradeName }.joinedString),
            MovieInfoView(title: MovieInfoTitle.nationName, content: item.nations.map { $0.nationName}.joinedString),
            MovieInfoView(title: MovieInfoTitle.genreName, content: item.genres.map { $0.genreName }.joinedString),
            MovieInfoView(title: MovieInfoTitle.actorName, content: item.actors.map { $0.name }.joinedString),
        ]
        
        labels.forEach {
            mainStackView.addArrangedSubview($0)
            $0.widthAnchor.constraint(equalTo: mainStackView.widthAnchor).isActive = true
        }
    }
    
    private func setupViews() {
        view.addSubview(scrollView)
        scrollView.addSubview(imageView)
        scrollView.addSubview(mainStackView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor, constant: 15),
            imageView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor, constant: -15),
        ])
        
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: imageView.bottomAnchor),
            mainStackView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            mainStackView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            mainStackView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            mainStackView.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor),
        ])
        
        imageView.addSubview(indicatorView)
        NSLayoutConstraint.activate([
            indicatorView.centerXAnchor.constraint(equalTo: imageView.centerXAnchor),
            indicatorView.centerYAnchor.constraint(equalTo: imageView.centerYAnchor),
        ])
        
    }
    
    private func stopIndicator() {
        indicatorView.stopAnimating()
        indicatorView.isHidden = true
    }
    
    private func formatDate(_ dateString: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd"
        if let date = dateFormatter.date(from: dateString) {
            dateFormatter.dateFormat = "yyyy-MM-dd"
            return dateFormatter.string(from: date)
        }
        return dateString
    }
        
}
