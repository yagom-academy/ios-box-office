//
//  MovieDetailView.swift
//  BoxOffice
//
//  Created by EtialMoon, Minsup on 2023/08/08.
//

import UIKit

final class MovieDetailView: UIView {
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        return scrollView
    }()
    
    private let contentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.alignment = .center
        return stackView
    }()
    
    private let posterImageView: UIImageView = {
        let image = UIImageView()
        return image
    }()
    
    private let detailStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 8
        stackView.axis = .vertical
        return stackView
    }()
    
    convenience init() {
        self.init(frame: .zero)
        configureView()
        backgroundColor = .systemBackground
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configurePosterImage(_ image: UIImage?) {
        posterImageView.image = image
        updatePosterImageViewConstraints()
    }
    
    func configureMovieInformation(_ movieInformation: MovieInformation?) {
        let trimmedValue = prettyMovieInformation(movieInformation)
        let key = makeKeyTexts()
        let keysAndValue = zip(key, trimmedValue)
        
        for (key, value) in keysAndValue {
            let detailStackCell = createDetailStackCell(key: key, value: value)
            detailStackView.addArrangedSubview(detailStackCell)
        }
    }
    
    private func prettyMovieInformation(_ movieInformation: MovieInformation?) -> [String] {
        guard let movieInformation = movieInformation else { return [] }
        
        let directors = movieInformation.directors.map(\.peopleName).joined(separator: ", ")
        let productionYear = movieInformation.productionYear
        let openDate = movieInformation.openDate.dateFormat
        let runningTime = movieInformation.runningTime
        let watchGrade = movieInformation.audits.first?.watchGrade ?? ""
        let nations = movieInformation.nations.map(\.nationName).joined(separator: ", ")
        let genres = movieInformation.genres.map(\.genreName).joined(separator: ", ")
        let actors = movieInformation.actors.map(\.peopleName).joined(separator: ", ")
        
        return [directors, productionYear, openDate, runningTime, watchGrade, nations, genres, actors]
    }
    
    private func makeKeyTexts() -> [String] {
        return ["감독", "제작년도", "개봉일", "상영시간", "관람등급", "제작국가", "장르","배우"]
    }
}

// MARK: - Configuration
extension MovieDetailView {
    func configureView() {
        addSubviews()
        setUpConstraints()
    }
    
    private func addSubviews() {
        addSubview(scrollView)
        scrollView.addSubview(contentStackView)
        [posterImageView, detailStackView].forEach {
            contentStackView.addArrangedSubview($0)
        }
    }
    
    private func createDetailStackCell(key: String, value: String?) -> UIStackView {
        let stackView: UIStackView = {
            let stackView = UIStackView()
            stackView.spacing = 20
            stackView.axis = .horizontal
            return stackView
        }()
        
        let keyLabel = UILabel.key(text: key)
        let valueLabel = UILabel.value(text: value)
        
        [keyLabel, valueLabel].forEach {
            stackView.addArrangedSubview($0)
        }
        
        keyLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            keyLabel.widthAnchor.constraint(equalToConstant: 60)
        ])
        
        return stackView
    }
}

// MARK: - Constraints
extension MovieDetailView {
    private func setUpConstraints() {
        scrollViewConstraints()
        contentStackViewConstraints()
        posterImageViewConstraints()
        detailStackViewConstraints()
    }
    
    private func scrollViewConstraints() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scrollView.frameLayoutGuide.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            scrollView.frameLayoutGuide.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            scrollView.frameLayoutGuide.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            scrollView.frameLayoutGuide.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            scrollView.contentLayoutGuide.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor)
        ])
    }
    
    private func contentStackViewConstraints() {
        contentStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contentStackView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor, constant: 20),
            contentStackView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor, constant: -20),
            contentStackView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            contentStackView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor)
        ])
    }
    
    private func posterImageViewConstraints() {
        posterImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            posterImageView.widthAnchor.constraint(equalTo: contentStackView.widthAnchor, multiplier: 1)
        ])
    }
    
    private func updatePosterImageViewConstraints() {
        guard let imageWidth = posterImageView.image?.size.width,
              let imageHeight = posterImageView.image?.size.height else { return }
        let ratio = posterImageView.frame.width / imageWidth
        let height = ratio * imageHeight
        posterImageView.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    private func detailStackViewConstraints() {
        detailStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            detailStackView.widthAnchor.constraint(equalTo: contentStackView.widthAnchor)
        ])
    }
}
