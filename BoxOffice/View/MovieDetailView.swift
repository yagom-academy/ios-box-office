//
//  MovieDetailView.swift
//  BoxOffice
//
//  Created by Serena, BMO on 2023/08/06.
//

import UIKit

final class MovieDetailView: UIView {
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints  = false
        
        return scrollView
    }()
    
    let contentView: UIView = {
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        return contentView
    }()
    
    let posterImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        
        return image
    }()
    
    private let totalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.alignment = .leading
        stackView.distribution = .equalSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    private let directorContentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        
        return stackView
    }()
    
    private let directorTitleLabel = TitleLabel(title: MovieDetailNameSpace.director)
    
    let directorDetailLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.minimumScaleFactor = 0.3
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.adjustsFontForContentSizeCategory = true
        label.adjustsFontSizeToFitWidth = true
        
        return label
    }()
    
    private let productionYearContentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 4
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        
        return stackView
    }()
    
    private let productionYearTitleLabel = TitleLabel(title: MovieDetailNameSpace.productionYear)
    
    let productionYearDetailLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.minimumScaleFactor = 0.3
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.adjustsFontForContentSizeCategory = true
        label.adjustsFontSizeToFitWidth = true
        
        return label
    }()
    
    private let openDateContentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 4
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        
        return stackView
    }()
    
    private let openDateTitleLabel = TitleLabel(title: MovieDetailNameSpace.openDate)
    
    let openDateDetailLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.minimumScaleFactor = 0.3
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.adjustsFontForContentSizeCategory = true
        label.adjustsFontSizeToFitWidth = true
        
        return label
    }()
    
    private let showTimeContentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 4
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        
        return stackView
    }()
    
    private let showTimeTitleLabel = TitleLabel(title: MovieDetailNameSpace.showTime)
    
    let showTimeDetailLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.minimumScaleFactor = 0.3
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.adjustsFontForContentSizeCategory = true
        label.adjustsFontSizeToFitWidth = true
        
        return label
    }()
    
    private let watchGradeNameContentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 4
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        
        return stackView
    }()
    
    private let watchGradeNameTitleLabel = TitleLabel(title: MovieDetailNameSpace.watchGradeName)
    
    let watchGradeNameDetailLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.minimumScaleFactor = 0.3
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.adjustsFontForContentSizeCategory = true
        label.adjustsFontSizeToFitWidth = true
        
        return label
    }()
    
    private let nationNameContentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 4
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        
        return stackView
    }()
    
    private let nationNameTitleLabel = TitleLabel(title: MovieDetailNameSpace.nationName)
    
    let nationNameDetailLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.minimumScaleFactor = 0.3
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.adjustsFontForContentSizeCategory = true
        label.adjustsFontSizeToFitWidth = true
        
        return label
    }()
    
    private let genreNameContentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 4
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        
        return stackView
    }()
    
    private let genreNameTitleLabel = TitleLabel(title: MovieDetailNameSpace.genreName)
    
    let genreNameDetailLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.minimumScaleFactor = 0.3
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.adjustsFontForContentSizeCategory = true
        label.adjustsFontSizeToFitWidth = true
        
        return label
    }()
    
    private let actorsContentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 4
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        
        return stackView
    }()
    
    private let actorTitleLabel = TitleLabel(title: MovieDetailNameSpace.actor)
    
    let actorDetailLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.minimumScaleFactor = 0.3
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.adjustsFontForContentSizeCategory = true
        label.adjustsFontSizeToFitWidth = true
        
        return label
    }()
    
    convenience init() {
        self.init(frame: CGRectZero)
        
        configureUI()
        setUpConstraints()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(posterImage)
        contentView.addSubview(totalStackView)
        [directorContentStackView, productionYearContentStackView, openDateContentStackView, showTimeContentStackView, watchGradeNameContentStackView, nationNameContentStackView, genreNameContentStackView, actorsContentStackView].forEach { totalStackView.addArrangedSubview($0) }
        [directorTitleLabel, directorDetailLabel].forEach { directorContentStackView.addArrangedSubview($0) }
        [productionYearTitleLabel, productionYearDetailLabel].forEach { productionYearContentStackView.addArrangedSubview($0) }
        [openDateTitleLabel, openDateDetailLabel].forEach { openDateContentStackView.addArrangedSubview($0) }
        [showTimeTitleLabel, showTimeDetailLabel].forEach { showTimeContentStackView.addArrangedSubview($0) }
        [watchGradeNameTitleLabel, watchGradeNameDetailLabel].forEach { watchGradeNameContentStackView.addArrangedSubview($0) }
        [nationNameTitleLabel, nationNameDetailLabel].forEach { nationNameContentStackView.addArrangedSubview($0) }
        [genreNameTitleLabel, genreNameDetailLabel].forEach { genreNameContentStackView.addArrangedSubview($0) }
        [actorTitleLabel, actorDetailLabel].forEach { actorsContentStackView.addArrangedSubview($0) }
    }
    
    private func setUpConstraints() {
        setUpScrollViewConstraints()
        setUpContentViewConstraints()
        setUpPosterImageViewConstraints()
        setUpTotalStackViewConstraints()
        setUpTitleLabelsAlign()
        setUpDetailLabelsAlign()
    }
}

// MARK: - Constraints
extension MovieDetailView {
    private func setUpScrollViewConstraints() {
        NSLayoutConstraint.activate([
            scrollView.frameLayoutGuide.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            scrollView.frameLayoutGuide.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            scrollView.frameLayoutGuide.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            scrollView.frameLayoutGuide.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func setUpContentViewConstraints() {
        NSLayoutConstraint.activate([
            contentView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            contentView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor, multiplier: 1)
        ])
        
        let contentViewHeightConstraints = contentView.heightAnchor.constraint(equalTo: scrollView.frameLayoutGuide.heightAnchor, constant: 1)
        contentViewHeightConstraints.priority = .init(1)
        contentViewHeightConstraints.isActive = true
    }
    
    private func setUpPosterImageViewConstraints() {
        NSLayoutConstraint.activate([
            posterImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            posterImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            posterImage.topAnchor.constraint(equalTo: contentView.topAnchor)
        ])
    }
    
    private func setUpTotalStackViewConstraints() {
        NSLayoutConstraint.activate([
            totalStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            totalStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            totalStackView.topAnchor.constraint(equalTo: posterImage.bottomAnchor, constant: 8),
            totalStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    private func setUpTitleLabelsAlign() {
        NSLayoutConstraint.activate([
            productionYearTitleLabel.centerXAnchor.constraint(equalTo: directorTitleLabel.centerXAnchor),
            openDateTitleLabel.centerXAnchor.constraint(equalTo: directorTitleLabel.centerXAnchor),
            showTimeTitleLabel.centerXAnchor.constraint(equalTo: directorTitleLabel.centerXAnchor),
            watchGradeNameTitleLabel.centerXAnchor.constraint(equalTo: directorTitleLabel.centerXAnchor),
            nationNameTitleLabel.centerXAnchor.constraint(equalTo: directorTitleLabel.centerXAnchor),
            genreNameTitleLabel.centerXAnchor.constraint(equalTo: directorTitleLabel.centerXAnchor),
            actorTitleLabel.centerXAnchor.constraint(equalTo: directorTitleLabel.centerXAnchor)
        ])
    }
    
    private func setUpDetailLabelsAlign() {
        NSLayoutConstraint.activate([
            productionYearDetailLabel.leadingAnchor.constraint(equalTo: directorDetailLabel.leadingAnchor),
            openDateDetailLabel.leadingAnchor.constraint(equalTo: directorDetailLabel.leadingAnchor),
            showTimeDetailLabel.leadingAnchor.constraint(equalTo: directorDetailLabel.leadingAnchor),
            watchGradeNameDetailLabel.leadingAnchor.constraint(equalTo: directorDetailLabel.leadingAnchor),
            nationNameDetailLabel.leadingAnchor.constraint(equalTo: directorDetailLabel.leadingAnchor),
            genreNameDetailLabel.leadingAnchor.constraint(equalTo: directorDetailLabel.leadingAnchor),
            actorDetailLabel.leadingAnchor.constraint(equalTo: directorDetailLabel.leadingAnchor)
        ])
    }
}
