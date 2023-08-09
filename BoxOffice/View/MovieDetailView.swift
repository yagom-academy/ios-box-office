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
        image.contentMode = .scaleAspectFit
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
    
    func injectMovieInformation(_ movieInformation: MovieInformation?, image: UIImage?) {
        posterImageView.image = image
        guard let movieInformation = movieInformation else { return }
        [createInformationLine(key: "감독", value: movieInformation.directors.description),
         createInformationLine(key: "제작년도", value: movieInformation.productionYear),
         createInformationLine(key: "개봉일", value: movieInformation.openDate),
         createInformationLine(key: "상영시간", value: movieInformation.runningTime),
         createInformationLine(key: "관람등급", value: movieInformation.audits.first?.watchGradeName),
         createInformationLine(key: "제작국가", value: movieInformation.nations.description),
         createInformationLine(key: "장르", value: movieInformation.genres.description),
         createInformationLine(key: "배우", value: movieInformation.actors.description)
        ].forEach {
            detailStackView.addArrangedSubview($0)
        }
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
    
    private func createInformationLine(key: String, value: String?) -> UIStackView {
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
            posterImageView.widthAnchor.constraint(equalTo: contentStackView.widthAnchor, multiplier: 1),
            posterImageView.heightAnchor.constraint(lessThanOrEqualTo: safeAreaLayoutGuide.heightAnchor, multiplier: 1)
        ])
    }
    
    private func detailStackViewConstraints() {
        detailStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            detailStackView.widthAnchor.constraint(equalTo: contentStackView.widthAnchor)
        ])
    }
}
