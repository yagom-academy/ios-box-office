//
//  DailyMovieListCell.swift
//  BoxOffice
//
//  Created by 리지, kokkilE on 2023/03/27.
//

import UIKit

@available(iOS 14.0, *)
final class DailyMovieListCell: UICollectionViewListCell {
    static let reuseIdentifier = "DailyMovieListCell"
    private var movie: DailyBoxOffice.BoxOfficeResult.Movie? = nil
    
    private lazy var movieListContentView = UIListContentView(configuration: defaultListContentConfiguration())
    private lazy var movieRankContentView = UIListContentView(configuration: defaultListContentConfiguration())
    private var customViewConstraints: (categoryLabelLeading: NSLayoutConstraint,
                                categoryLabelTrailing: NSLayoutConstraint,
                                categoryIconTrailing: NSLayoutConstraint)?
    private var separatorConstraint: NSLayoutConstraint?
    override var configurationState: UICellConfigurationState {
        var state = super.configurationState
        state.movie = self.movie
        return state
    }
    
    func updateWithItem(_ newItem: DailyBoxOffice.BoxOfficeResult.Movie) {
        guard movie != newItem else { return }
        movie = newItem
        setNeedsUpdateConfiguration()
    }
    
    private func defaultListContentConfiguration() -> UIListContentConfiguration {
        return .subtitleCell()
    }
    
    private func configureContentView() {
        guard customViewConstraints == nil else { return }
        
        contentView.addSubview(movieListContentView)
        contentView.addSubview(movieRankContentView)
        
        movieListContentView.translatesAutoresizingMaskIntoConstraints = false
        movieRankContentView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            movieRankContentView.topAnchor.constraint(equalTo: contentView.topAnchor),
            movieRankContentView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            movieRankContentView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            movieRankContentView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.2),
            movieListContentView.topAnchor.constraint(equalTo: contentView.topAnchor),
            movieListContentView.leadingAnchor.constraint(equalTo: movieRankContentView.trailingAnchor),
            movieListContentView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            movieListContentView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }
    
    private func updateSeparatorConstraint() {
        guard let textLayoutGuide = movieListContentView.textLayoutGuide else { return }
        if let existingConstraint = separatorConstraint, existingConstraint.isActive {
            return
        }
        let constraint = separatorLayoutGuide.leadingAnchor.constraint(equalTo: textLayoutGuide.leadingAnchor)
        constraint.isActive = true
        separatorConstraint = constraint
    }
    
    // MARK: UpdateConfiguration
    override func updateConfiguration(using state: UICellConfigurationState) {
        configureContentView()
        
        // MARK: movieListContent
        var movieListContent = defaultListContentConfiguration().updated(for: state)
        
        guard let movie = state.movie,
              let todayAudience = movie.audienceCount.convertToFormattedNumber(),
              let totalAudience = movie.audienceAccumulation.convertToFormattedNumber() else { return }
        
        movieListContent.text = movie.name
        movieListContent.textProperties.font = UIFont.preferredFont(forTextStyle: .title3)
        movieListContent.secondaryText = "오늘 \(todayAudience) / 총 \(totalAudience)"
        movieListContent.secondaryTextProperties.font = UIFont.preferredFont(forTextStyle: .body)
        
        movieListContent.axesPreservingSuperviewLayoutMargins = []
        movieListContentView.configuration = movieListContent
        
        // MARK: movieRankContent
        var movieRankContent = defaultListContentConfiguration().updated(for: state)
        
        movieRankContent.text = movie.order
        movieRankContent.textProperties.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        movieRankContent.textProperties.alignment = .center
        
        if movie.rankOldAndNew == "NEW" {
            movieRankContent.secondaryText = "신작"
            movieRankContent.secondaryTextProperties.color = .systemRed
        } else {
            guard let variance = Int(movie.rankVariance) else { return }
            switch variance {
            case ..<0:
                let text =  "▼\(variance * -1)"
                let attributedString = NSMutableAttributedString(string: text)
                attributedString.addAttribute(.foregroundColor, value: UIColor.blue, range: (text as NSString).range(of: "▼"))
                movieRankContent.secondaryAttributedText = attributedString
            case 0:
                movieRankContent.secondaryText = "-"
            default:
                let text = "▲\(variance)"
                let attributedString = NSMutableAttributedString(string: text)
                attributedString.addAttribute(.foregroundColor, value: UIColor.red, range: (text as NSString).range(of: "▲"))
                movieRankContent.secondaryAttributedText = attributedString
            }
        }
        
        movieRankContent.secondaryTextProperties.font = UIFont.preferredFont(forTextStyle: .body)
        movieRankContent.secondaryTextProperties.alignment = .center
        
        movieRankContent.axesPreservingSuperviewLayoutMargins = []
        movieRankContentView.configuration = movieRankContent
        
        let valueConfiguration = UIListContentConfiguration.valueCell().updated(for: state)
        
        customViewConstraints?.categoryLabelLeading.constant = movieListContent.directionalLayoutMargins.trailing
        customViewConstraints?.categoryLabelTrailing.constant = valueConfiguration.textToSecondaryTextHorizontalPadding
        customViewConstraints?.categoryIconTrailing.constant = movieListContent.directionalLayoutMargins.trailing
        
        updateSeparatorConstraint()
    }
}

@available(iOS 14.0, *)
extension UIConfigurationStateCustomKey {
    static let movieKey = UIConfigurationStateCustomKey("movie")
}

@available(iOS 14.0, *)
extension UICellConfigurationState {
    var movie: DailyBoxOffice.BoxOfficeResult.Movie? {
        get { return self[.movieKey] as? DailyBoxOffice.BoxOfficeResult.Movie }
        set { self[.movieKey] = newValue }
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
