//
//  DailyBoxOfficeCollectionViewCell.swift
//  BoxOffice
//
//  Created by 리지, kokkilE on 2023/03/27.
//

import UIKit

final class DailyBoxOfficeCollectionViewCell: UICollectionViewCell {
    static let reuseIdentifier = "DailyBoxOfficeCollectionViewCell"

    private var accessoryImageView = UIImageView()
    private var separatorView = UIView()
    
    private var mainStackView = UIStackView()
    
    private var movieRankStackView = UIStackView()
    private var movieRankLabel = UILabel()
    private var audienceVarianceLabel = UILabel()
    
    private var movieListStackView = UIStackView()
    private var movieListLabel = UILabel()
    private var audienceInformationLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        audienceVarianceLabel.textColor = .black
    }
    
    private func configureCell() {
        configureContentView()
        configureSeparatorView()
        configureMainStackView()
        configureMovieRankStackView()
        configureMovieListStackView()
        configureAccessoryImageView()
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
        separatorView.autoresizingMask = .flexibleWidth
        separatorView.backgroundColor = .placeholderText
        
        addSubview(separatorView)
    }
    
    private func configureMainStackView() {
        mainStackView.axis = .horizontal
        mainStackView.alignment = .center
        mainStackView.distribution = .fill
        mainStackView.spacing = 5
        mainStackView.addArrangedSubview(movieRankStackView)
        mainStackView.addArrangedSubview(movieListStackView)
        mainStackView.addArrangedSubview(accessoryImageView)
        
        addSubview(mainStackView)
        
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mainStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            mainStackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            mainStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            mainStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20)
        ])
    }
    
    private func configureMovieRankStackView() {
        movieRankStackView.axis = .vertical
        movieRankStackView.distribution = .fill
        
        movieRankStackView.addArrangedSubview(movieRankLabel)
        movieRankStackView.addArrangedSubview(audienceVarianceLabel)
        
        movieRankStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            movieRankStackView.widthAnchor.constraint(equalTo: mainStackView.widthAnchor, multiplier: 0.2)
        ])
    }
    
    private func configureMovieListStackView() {
        movieListStackView.axis = .vertical
        movieListStackView.distribution = .fillProportionally
        movieListStackView.spacing = 5
        
        movieListStackView.addArrangedSubview(movieListLabel)
        movieListStackView.addArrangedSubview(audienceInformationLabel)
    }
    
    private func configureAccessoryImageView() {
        accessoryImageView.image = UIImage(systemName: "chevron.right")?.withTintColor(.systemGray2, renderingMode: .alwaysOriginal)
        
        accessoryImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            accessoryImageView.trailingAnchor.constraint(equalTo: mainStackView.trailingAnchor),
            accessoryImageView.widthAnchor.constraint(equalTo: mainStackView.widthAnchor, multiplier: 0.025),
            accessoryImageView.heightAnchor.constraint(equalTo: mainStackView.heightAnchor, multiplier: 0.2)
        ])
    }
    
    func configure(with movie: DailyBoxOffice.BoxOfficeResult.Movie) {
        setupMovieListLabels(with: movie)
        setupMovieRankLabels(with: movie)
    }
    
    private func setupMovieListLabels(with movie: DailyBoxOffice.BoxOfficeResult.Movie) {
        guard let todayAudience = movie.audienceCount.convertToFormattedNumber(),
              let totalAudience = movie.audienceAccumulation.convertToFormattedNumber() else { return }
        
        movieListLabel.text = movie.name
        movieListLabel.font = UIFont.preferredFont(forTextStyle: .title3)
        movieListLabel.numberOfLines = 0
        
        audienceInformationLabel.text = "오늘 \(todayAudience) / 총 \(totalAudience)"
        audienceInformationLabel.font = UIFont.preferredFont(forTextStyle: .body)
    }
    
    private func setupMovieRankLabels(with movie: DailyBoxOffice.BoxOfficeResult.Movie) {
        movieRankLabel.text = movie.order
        movieRankLabel.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        movieRankLabel.textAlignment = .center
        
        if movie.rankOldAndNew == "NEW" {
            audienceVarianceLabel.text = "신작"
            audienceVarianceLabel.textColor = .systemRed
        } else {
            guard let variance = Int(movie.rankVariance) else { return }
            
            switch variance {
            case ..<0:
                let text =  "▼\(variance * -1)"
                let attributedString = NSMutableAttributedString(string: text)
                attributedString.addAttribute(.foregroundColor, value: UIColor.blue, range: (text as NSString).range(of: "▼"))
                audienceVarianceLabel.attributedText = attributedString
            case 0:
                audienceVarianceLabel.text = "-"
            default:
                let text = "▲\(variance)"
                let attributedString = NSMutableAttributedString(string: text)
                attributedString.addAttribute(.foregroundColor, value: UIColor.red, range: (text as NSString).range(of: "▲"))
                audienceVarianceLabel.attributedText = attributedString
            }
        }
        
        audienceVarianceLabel.font = UIFont.preferredFont(forTextStyle: .body)
        audienceVarianceLabel.textAlignment = .center
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
