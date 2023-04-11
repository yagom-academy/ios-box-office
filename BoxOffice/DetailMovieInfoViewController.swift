//
//  DetailMovieInfoViewController.swift
//  BoxOffice
//
//  Created by Seoyeon Hong on 2023/03/31.
//

import UIKit

final class DetailMovieInfoViewController: UIViewController {
    
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
        fetchImageforMovie(name: movieName)
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
                    let movieInfo: MovieInfoItem = try JSONConverter.shared.decodeData(data, MovieInfoItem.self)
                    let movieInfoItem = movieInfo.movieInfoResult.movieInfo
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
    
    private func fetchImageforMovie(name: String) {
        let query = ImageAPI.imageQuery(movieName)
        let imageAPI = ImageAPI.imageSearchQuery(query: query)
        
        provider.performImageRequest(api: imageAPI) { [weak self] requestResult in
            guard let self else { return }
            switch requestResult {
            case .success(let data):
                do {
                    let imageSearchResult: ImageSearchResult = try JSONConverter.shared.decodeData(data, ImageSearchResult.self)
                    if let imageInfo = imageSearchResult.documents.first,
                       let url = URL(string: imageInfo.imageUrl) {
                        self.imageView.loadImage(url: url, originalWidth: imageInfo.width)
                        DispatchQueue.main.async {
                            self.stopIndicator()
                        }
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
    
    private func updateStackView(_ item: MovieInfo) {
        mainStackView.arrangedSubviews.forEach { mainStackView.removeArrangedSubview($0) }
        
        let labels = [
            MovieInfoView(title: MovieInfoTitle.director, content: item.directors.map { $0.peopleName }.joinedString),
            MovieInfoView(title: MovieInfoTitle.productionYear, content: item.productionYear),
            MovieInfoView(title: MovieInfoTitle.openDate, content: DateManager.formattedDateString(of: item.openDate) ?? ""),
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
        imageView.addSubview(indicatorView)
        
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
        
        NSLayoutConstraint.activate([
            indicatorView.centerXAnchor.constraint(equalTo: imageView.centerXAnchor),
            indicatorView.centerYAnchor.constraint(equalTo: imageView.centerYAnchor),
        ])
        
    }
    
    private func startIndicator() {
        indicatorView.isHidden = false
        indicatorView.startAnimating()
    }
    
    private func stopIndicator() {
        indicatorView.stopAnimating()
        indicatorView.isHidden = true
    }
        
}
