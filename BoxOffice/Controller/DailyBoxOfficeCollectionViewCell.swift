//
//  DailyBoxOfficeCollectionViewCell.swift
//  BoxOffice
//
//  Created by 리지, kokkilE on 2023/03/27.
//

import UIKit

final class DailyBoxOfficeCollectionViewCell: UICollectionViewCell {
    static let reuseIdentifier = "DailyBoxOfficeCollectionViewCell"
    private var movie: DailyBoxOffice.BoxOfficeResult.Movie?
    private var movieListLabel = UILabel()
    private var movieRankLabel = UILabel()
    private var audienceInformationLabel = UILabel()
    private var audienceVarianceLabel = UILabel()
    private var movieRankStackView = UIStackView()
    private var movieListStackView = UIStackView()
    private var mainStackView = UIStackView()
    private var separatorView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureCell() {
        configureContentView()
        configureSeparatorView()
        configureMainStackView()
        configureRankStackView()
        configureMovieListStackView()
        configureLabels()
    }
    
    private func configureContentView() {
        contentView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contentView.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor, multiplier: 1.0),
            contentView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            contentView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor)
        ])
    }
    
    private func configureSeparatorView() {
        separatorView = UIView(frame: CGRect(x: 0, y: 0, width: contentView.frame.size.width, height: 1))
        separatorView.backgroundColor = .placeholderText
        
        addSubview(separatorView)
    }
    
    private func configureMainStackView() {
        mainStackView.axis = .horizontal
        mainStackView.alignment = .fill
        mainStackView.distribution = .fill
        mainStackView.spacing = 10
        mainStackView.addArrangedSubview(movieRankStackView)
        mainStackView.addArrangedSubview(movieListStackView)
        
        addSubview(mainStackView)
        
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mainStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            mainStackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            mainStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            mainStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }
    
    private func configureRankStackView() {
        movieRankStackView.axis = .vertical
        movieRankStackView.distribution = .fill
        
        movieRankStackView.addArrangedSubview(movieRankLabel)
        movieRankStackView.addArrangedSubview(audienceVarianceLabel)
        
        movieRankStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            movieRankStackView.topAnchor.constraint(equalTo: self.topAnchor),
            movieRankStackView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.2)
        ])
    }
    
    private func configureMovieListStackView() {
        movieListStackView.axis = .vertical
        movieListStackView.distribution = .fillProportionally
        
        movieListStackView.addArrangedSubview(movieListLabel)
        movieListStackView.addArrangedSubview(audienceInformationLabel)
        
        movieListStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            movieListStackView.topAnchor.constraint(equalTo: self.topAnchor),
            movieListStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }
    
    private func configureLabels() {
        movieListLabel.translatesAutoresizingMaskIntoConstraints = false
        audienceInformationLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            movieListLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            audienceInformationLabel.topAnchor.constraint(equalTo: movieListLabel.bottomAnchor),
            audienceInformationLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.2),
            audienceInformationLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
        
        movieRankLabel.translatesAutoresizingMaskIntoConstraints = false
        audienceVarianceLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            movieRankLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            audienceVarianceLabel.topAnchor.constraint(equalTo: movieRankLabel.bottomAnchor),
            audienceVarianceLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.2),
            audienceVarianceLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }
    
    func configure(with movieModel: DailyBoxOffice.BoxOfficeResult.Movie) {
        self.movie = movieModel
        setupMovieListLabels()
        setupMovieRankLabels()
    }
    
    private func setupMovieListLabels() {
        guard let movie = movie,
              let todayAudience = movie.audienceCount.convertToFormattedNumber(),
              let totalAudience = movie.audienceAccumulation.convertToFormattedNumber() else { return }
        
        self.movieListLabel.text = movie.name
        self.movieListLabel.font = UIFont.preferredFont(forTextStyle: .title3)
        self.movieListLabel.numberOfLines = 0
        
        self.audienceInformationLabel.text = "오늘 \(todayAudience) / 총 \(totalAudience)"
        self.audienceInformationLabel.font = UIFont.preferredFont(forTextStyle: .body)
    }
    
    private func setupMovieRankLabels() {
        guard let movie = movie else { return }
        
        self.movieRankLabel.text = movie.order
        self.movieRankLabel.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        self.movieRankLabel.textAlignment = .center
        
        if movie.rankOldAndNew == "NEW" {
            self.audienceVarianceLabel.text = "신작"
            self.audienceVarianceLabel.textColor = .systemRed
        } else {
            guard let variance = Int(movie.rankVariance) else { return }
            switch variance {
            case ..<0:
                self.audienceVarianceLabel.text = "🔻\(variance * -1)"
            case 0:
                self.audienceVarianceLabel.text = "-"
            default:
                self.audienceVarianceLabel.text = "🔺\(variance)"
            }
        }
        
        self.audienceVarianceLabel.font = UIFont.preferredFont(forTextStyle: .body)
        self.audienceVarianceLabel.textAlignment = .center
    }
}

fileprivate extension String {
    func convertToFormattedNumber() -> String? {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        
        guard let number = numberFormatter.number(from: self),
              let stringNumber = numberFormatter.string(from: number) else { return nil }
        
        return stringNumber
    }
}



